//
//  Laser.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/18/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Laser: Projectile {
    
    init() {
        super.init(sprite: _magic.get("laserSprite") as String, size: _magic.get("laserSize") as CGFloat)
        
        zPosition = 999
        name = "laserNode"
        //physicsBody?.categoryBitMask = PhysicsCategory.Laser
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}