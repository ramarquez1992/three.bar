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
    var moving:CGPoint? = nil  // Direction moving, or nil if not moving
    
    init() {
        //super.init(texture: SKTexture(imageNamed: _magic.mobSprite),
        super.init(texture: nil,
            color: UIColor.purpleColor(),
            size: CGSize(width: CGFloat(_magic.mobSize), height: CGFloat(_magic.mobSize)))
        
        zPosition = 800  // Below hero
        name = "mobNode"
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