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
        case .NotFound:
            return .notFound
        case .NotEnabled:
            return .notEnabled
        case .Disconnected:
            return .disconnected
        case .Connected:
            return .connected
        @unknown default:
            return .notFound
        }
    }
}
