//
//  Mob.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/16/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Mob: Actor {    
    init() {
        super.init(texture: SKTexture(imageNamed: _magic.get("mobSprite") as String),
        //super.init(texture: nil,
            color: UIColor.purpleColor(),
            size: CGSize(width: _magic.get("mobSize") as CGFloat, height: _magic.get("mobSize") as CGFloat))
        
        zPosition = 800  // Below hero
        name = "mobNode"
        physicsBody?.categoryBitMask = PhysicsCategory.Mob

    }
    
    func move(location: CGPoint, map: GameScene) {
        //TODO:
    }
    
    func shoot(direction: CGPoint, map: GameScene) {
        //TODO: fire projectile
        
        //TODO: Play sound effect
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}