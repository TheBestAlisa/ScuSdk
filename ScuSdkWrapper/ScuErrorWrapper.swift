//
//  ScuErrorWrapper.swift
//  ScuSdkWrapper
//
//  Created by Alisa Martirosyan on 13.11.24.
//

import ScuSdk

@objc
public enum ScuErrorWrapper: Int {
    case commandNotSupported
    case connectionIsNotReady
    case commandFailed
    case invalidKey
    case unkown
    
    public static func wrap(_ error: ScuError?) -> ScuErrorWrapper {
        switch error {
        case .CommandNotSupported:
            return .commandNotSupported
        case .ConnectionIsNotReady:
            return .connectionIsNotReady
        case .CommandFailed:
            return .commandFailed
        case .InvalidKey:
            return .invalidKey
        case .none:
            return .unkown
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .commandNotSupported:
            return ScuError.CommandNotSupported.errorDescription
        case .connectionIsNotReady:
            return ScuError.ConnectionIsNotReady.errorDescription
        case .commandFailed:
            return ScuError.CommandFailed.errorDescription
        case .invalidKey:
            return ScuError.InvalidKey.errorDescription
        case .unkown:
            return "Something went wrong"
        }
    }
    
    public var originalRawValue: String {
        switch self {
        case .commandNotSupported:
            return ScuError.CommandNotSupported.rawValue
        case .connectionIsNotReady:
            return ScuError.ConnectionIsNotReady.rawValue
        case .commandFailed:
            return ScuError.CommandFailed.rawValue
        case .invalidKey:
            return ScuError.InvalidKey.rawValue
        case .unkown:
            return "Something went wrong"
        }
    }
}
