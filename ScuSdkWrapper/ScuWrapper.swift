//
//  ScuWrapper.swift
//  ScuSdkWrapper
//
//  Created by Alisa Martirosyan on 13.11.24.
//

import ScuSdk

@objcMembers
public class ScuWrapper: NSObject {
    
    public static let shared = ScuWrapper()
    
    private let scuSdk: Scu
    private let queue = DispatchQueue(label: "com.scuwrapper.queue", qos: .background)
    
    private override init() {
        self.scuSdk = Scu.shared
    }
    
    /// Scu SDK version
    public var version: String { scuSdk.version }
    
    /// Callback used to receive the status of the command sent.
    /// Returns the command [ScuCommand] and a Bool value containing the status.
    public var commandStatusCallback: ((ScuCommandWrapper, Bool) -> Void)? {
        get { getCommanStatusCallback() }
        set { setCommanStatusCallback(newValue) }
    }
    
    /// Callback used to receive the BcmDoor
    public var bcmDoorChangeCallback: ((BcmDoorWrapper) -> Void)? = nil
}

// - MARK: States
extension ScuWrapper {
    
    /// Callback for when the connection state changes.
    public func bleConnectionStateDidChanged(to completion: @escaping (BleConnectionStateWrapper) -> Void) {
        scuSdk.bleConnectionStateDidChanged { state in
            completion(state.getWrapperValue())
        }
    }
}

// - MARK: Utility
extension ScuWrapper {
    
    /// Connects to the PKC
    /// Takes a 16Byte security key as a parameter in the form of a hex string.
    /// Example: "00112233445566778899AABBCCDDEEFF"
    /// If the provided key is not 32 characters long, an error will be thrown.
    public func connect(key: String) {
        queue.async { [weak self] in
            guard let self else { return }
            do {
                try scuSdk.connect(key: key)
            } catch {
                print("Failed to connect: \(error.localizedDescription)")
            }
        }
    }
    
    /// Disconnects the PKC by removing the service and stopping advertising.
    public func disconnect() {
        queue.async { [weak self] in
            guard let self else { return }
            scuSdk.disconnect()
        }
    }
    
}

// - MARK: SDK Commands
extension ScuWrapper {
    
    /// Sends a command to the PKC.
    public func command(type: ScuCommandWrapper, completion: @escaping (String?) -> Void) {
        Task {
            do {
                print("Executing command: \(type)")
                try await scuSdk.command(type: type.getScuCommand())
                completion(nil) // No error, operation succeeded
            } catch {
                completion(error.localizedDescription)
            }
        }
    }
    
    /// Stops continuous notifications for a command.
    public func startContinuousNotification(type: ScuCommandWrapper, completion: @escaping (String?) -> Void) {
        Task {
            do {
                print("Start Continuous Notification Command: \(type)")
                try await scuSdk.startContinuousNotification(type: type.getScuCommand())
                completion(nil) // No error, operation successful
            } catch {
                completion(error.localizedDescription)
            }
        }
    }
    
    /// Stops continuous notifications for a command.
    public func stopContinuousNotification(type: ScuCommandWrapper) {
        scuSdk.stopContinuousNotification(type: type.getScuCommand())
    }

}

extension ScuWrapper: ScuStatusCommandDelegate {
    
    public func onBcmDoorChange(value: ScuSdk.BcmDoor) {
        bcmDoorChangeCallback?(value.getBcmDoorWrapper())
    }
    
    public func onPlgmTrSwChange(value: ScuSdk.PlgmTrSw) { }
    
    public func onBcmSunroofPosnChange(value: ScuSdk.BcmSunroofPosn) { }
    
}


// - MARK: Helpers
extension ScuWrapper {
    
    private func getCommanStatusCallback() -> ((ScuCommandWrapper, Bool) -> Void)? {
        guard let originalCallback = scuSdk.commandStatusCallback else { return nil }
        
        return { commandWrapper, status in
            let command = commandWrapper.getScuCommand()
            originalCallback(
                command,
                status
            )
        }
    }
    
    private func setCommanStatusCallback(_ newValue: ((ScuCommandWrapper, Bool) -> Void)?) {
        if let newCallback = newValue {
            scuSdk.commandStatusCallback = { command, status in
                let commandWrapper = command.getScuCommandWrapper()
                newCallback(commandWrapper, status)
            }
        } else {
            scuSdk.commandStatusCallback = nil
        }
    }
    
}
