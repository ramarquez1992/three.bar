//
//  Actor.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Actor: SKSpriteNode {
    var facing = CGPoint(x: 0, y: 0)
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        zPosition = 900
        setPhysics()
        
    }
    
    private func setPhysics() {
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        
        physicsBody?.dynamic                       = true
        physicsBody?.allowsRotation                = false
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask    = PhysicsCategory.Actor
        physicsBody?.contactTestBitMask = PhysicsCategory.Projectile +
                                          PhysicsCategory.Actor +
                                          PhysicsCategory.Hero +
                                          PhysicsCategory.Mob
        physicsBody?.collisionBitMask   = PhysicsCategory.All   -
                                          PhysicsCategory.Actor -
                                          PhysicsCategory.Hero -
                                          PhysicsCategory.Mob -
                                          PhysicsCategory.Projectile
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}