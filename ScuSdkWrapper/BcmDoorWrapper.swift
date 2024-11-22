//
//  BcmDoorWrapper.swift
//  ScuSdkWrapper
//
//  Created by Alisa Martirosyan on 13.11.24.
//

import ScuSdk

@objcMembers
public class BcmDoorWrapper: NSObject {
    
    public var readableName: String
    
    public var frontDoorsUnlocked: Bool
    
    public var driverFrontOpen: Bool
    
    public var passangerFrontOpen: Bool
    
    public var leftRearOpen: Bool
    
    public var rightRearOpen: Bool
    
    init(readableName: String, frontDoorsUnlocked: Bool, driverFrontOpen: Bool, passangerFrontOpen: Bool, leftRearOpen: Bool, rightRearOpen: Bool) {
        self.readableName = readableName
        self.frontDoorsUnlocked = frontDoorsUnlocked
        self.driverFrontOpen = driverFrontOpen
        self.passangerFrontOpen = passangerFrontOpen
        self.leftRearOpen = leftRearOpen
        self.rightRearOpen = rightRearOpen
    }
    
}

extension ScuSdk.BcmDoor {
    
    func getBcmDoorWrapper() -> BcmDoorWrapper {
        BcmDoorWrapper(
            readableName: readableName,
            frontDoorsUnlocked: frontDoorsUnlocked,
            driverFrontOpen: driverFrontOpen,
            passangerFrontOpen: passangerFrontOpen,
            leftRearOpen: leftRearOpen,
            rightRearOpen: rightRearOpen)
    }
    
}
