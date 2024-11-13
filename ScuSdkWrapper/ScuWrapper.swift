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
    
    private override init() { }
    
    /// Scu SDK version
    public let version: String = Scu.shared.version
    
    /// Callback used to receive the status of the command sent.
    /// Returns the command [ScuCommand] and a Bool value containing the status.
    public var commandStatusCallback: ((ScuCommandWrapper, Bool) -> Void)? {
        get {
            guard let originalCallback = Scu.shared.commandStatusCallback else { return nil }
            
            return { commandWrapper, status in
                let command = commandWrapper.getScuCommand()
                originalCallback(
                    command,
                    status
                )
            }
        }
        
        set {
            if let newCallback = newValue {
                Scu.shared.commandStatusCallback = { command, status in
                    let commandWrapper = command.getScuCommandWrapper()
                    newCallback(commandWrapper, status)
                }
            } else {
                Scu.shared.commandStatusCallback = nil
            }
        }
    }
    
}

// - MARK: States
extension ScuWrapper {
    
    /// Callback for when the connection state changes.
    public func bleConnectionStateDidChanged(to completion: @escaping (BleConnectionStateWrapper) -> Void) {
        Scu.shared.bleConnectionStateDidChanged { state in
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
        do {
            try Scu.shared.connect(key: key)
        } catch {
            print("Failed to connect: \(error)")
        }
    }
    
    /// Disconnects the PKC by removing the service and stopping advertising.
    public func disconnect() {
        Scu.shared.disconnect()
    }
    
}

// - MARK: SDK Commands
extension ScuWrapper {
    
    /// Sends a command to the PKC.
    public func command(type: ScuCommandWrapper, completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                try await Scu.shared.command(type: type.getScuCommand())
                completion(nil) // No error, operation succeeded
            } catch {
                completion(error as NSError) // Pass the error as NSError to Objective-C
            }
        }
    }
    
    /// Stops continuous notifications for a command.
    public func startContinuousNotification(type: ScuCommandWrapper, completion: @escaping (NSError?) -> Void) {
        Task {
            do {
                try await Scu.shared.startContinuousNotification(type: type.getScuCommand())
                completion(nil) // No error, operation successful
            } catch {
                completion(error as NSError) // Pass the error to Objective-C as NSError
            }
        }
    }
    
    /// Stops continuous notifications for a command.
    public func stopContinuousNotification(type: ScuCommandWrapper) {
        Scu.shared.stopContinuousNotification(type: type.getScuCommand())
    }
    
}

