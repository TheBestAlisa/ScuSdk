//
//  BleConnectionStateWrapper.swift
//  ScuSdkWrapper
//
//  Created by Alisa Martirosyan on 13.11.24.
//

import ScuSdk

@objc
public enum BleConnectionStateWrapper: Int {
    case notFound = 0
    case notEnabled
    case disconnected
    case connected
}

extension ScuSdk.BleConnectionState {
    func getWrapperValue()  -> BleConnectionStateWrapper {
        switch self {
        case .NotFound: // if LE is not supported by device
            return .notFound
        case .NotEnabled: // if Bluetooth is not enabled
            return .notEnabled
        case .Disconnected: // if there is no connection with ECU yet
            return .disconnected
        case .Connected: // successfully connected to ECU
            return .connected
        }
    }
}
