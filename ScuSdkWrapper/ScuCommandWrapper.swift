//
//  ScuCommandWrapper.swift
//  ScuSdkWrapper
//
//  Created by Alisa Martirosyan on 13.11.24.
//

import ScuSdk

@objc
public enum ScuCommandWrapper: Int {
    case windowsAllOpen = 0
    case windowsAllClose
    case windowTailgateActive
    case windowTailgateHalt
    case californiaModeToggle
    case tailgateActive
    case tailgateHalt
    case sunroofOpen
    case sunroofClose
    case vehicleLock
    case vehicleUnlock
    case vehicleStart
    case chargeGunUnlock
    
    func getScuCommand() -> ScuCommand {
        switch self {
        case .windowsAllOpen:
            return .windowsAllOpen
        case .windowsAllClose:
            return .windowsAllClose
        case .windowTailgateActive:
            return .windowTailgateActive
        case .windowTailgateHalt:
            return .windowTailgateHalt
        case .californiaModeToggle:
            return .californiaModeToggle
        case .tailgateActive:
            return .tailgateActive
        case .tailgateHalt:
            return .tailgateHalt
        case .sunroofOpen:
            return .sunroofOpen
        case .sunroofClose:
            return .sunroofClose
        case .vehicleLock:
            return .vehicleLock
        case .vehicleUnlock:
            return .vehicleUnlock
        case .vehicleStart:
            return .vehicleStart
        case .chargeGunUnlock:
            return .chargeGunUnlock
        }
    }
}

extension ScuCommand {
    func getScuCommandWrapper() -> ScuCommandWrapper {
        switch self {
        case .windowsAllOpen:
            return .windowsAllOpen
        case .windowsAllClose:
            return .windowsAllClose
        case .windowTailgateActive:
            return .windowTailgateActive
        case .windowTailgateHalt:
            return .windowTailgateHalt
        case .californiaModeToggle:
            return .californiaModeToggle
        case .tailgateActive:
            return .tailgateActive
        case .tailgateHalt:
            return .tailgateHalt
        case .sunroofOpen:
            return .sunroofOpen
        case .sunroofClose:
            return .sunroofClose
        case .vehicleLock:
            return .vehicleLock
        case .vehicleUnlock:
            return .vehicleUnlock
        case .vehicleStart:
            return .vehicleStart
        case .chargeGunUnlock:
            return .chargeGunUnlock
        @unknown default:
            fatalError()
        }
    }
}
