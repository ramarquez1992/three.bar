//
//  Projectile.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/17/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Projectile: Actor {
    
    init(sprite: String = _magic.get("projectileSprite") as String, size: CGFloat = _magic.get("projectileSize") as CGFloat) {
        super.init(texture: SKTexture(imageNamed: sprite),
            color: UIColor.greenColor(),
            size: CGSize(width: size, height: size))
        
        zPosition = 1000
        name = "projectileNode"
        physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}