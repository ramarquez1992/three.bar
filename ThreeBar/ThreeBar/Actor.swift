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
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        setPhysics()
        
    }
    
    private func setPhysics() {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        
        physicsBody?.dynamic = true
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask    = PhysicsCategory.Actor
        physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        physicsBody?.collisionBitMask   = PhysicsCategory.All   -
                                          PhysicsCategory.Actor -
                                          PhysicsCategory.Projectile
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}