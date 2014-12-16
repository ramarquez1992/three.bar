//
//  Magic.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/16/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

let _magic = Magic()

class Magic {
    let titleFont = String()
    let titleSize = Float()
    let titleText = String()
    
    let startButtonFont = String()
    let startButtonSize = Float()
    let startButtonText = String()
    
    let onboardingFont      = String()
    let onboardingSize      = Float()
    let onboardingMoveText  = String()
    let onboardingShootText = String()
    
    let scoreFont = String()
    let scoreSize = Float()
    
    let controlCenter = Float()
    
    let heroSprite       = String()
    let heroSize         = Float()
    let heroTeleportTime = Float()
    let heroMoveDistance = Float()
    let heroMoveSpeed    = Float()
    let flashDuration    = Float()
    
    let mobSprite = String()
    let mobSize   = Float()

    
    init() {
        if let path = NSBundle.mainBundle().pathForResource("Magic", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String:AnyObject] {
                
                titleFont = dict["titleFont"] as String
                titleSize = dict["titleSize"] as Float
                titleText = dict["titleText"] as String
                
                startButtonFont = dict["startButtonFont"] as String
                startButtonSize = dict["startButtonSize"] as Float
                startButtonText = dict["startButtonText"] as String
                
                onboardingFont      = dict["onboardingFont"] as String
                onboardingSize      = dict["onboardingSize"] as Float
                onboardingMoveText  = dict["onboardingMoveText"] as String
                onboardingShootText = dict["onboardingShootText"] as String
                
                scoreFont = dict["scoreFont"] as String
                scoreSize = dict["scoreSize"] as Float
                
                controlCenter = dict["controlCenter"] as Float
                
                heroSprite       = dict["heroSprite"] as String
                heroSize         = dict["heroSize"] as Float
                heroTeleportTime = dict["heroTeleportTime"] as Float
                heroMoveDistance = dict["heroMoveDistance"] as Float
                heroMoveSpeed    = dict["heroMoveSpeed"] as Float
                flashDuration    = dict["flashDuration"] as Float
                
                mobSprite = dict["mobSprite"] as String
                mobSize   = dict["mobSize"] as Float
            
            } else { fatalError("Failed to load \"Magic\" dictionary") }
        } else { fatalError("Failed to load \"Magic.plist\"") }
    }
}