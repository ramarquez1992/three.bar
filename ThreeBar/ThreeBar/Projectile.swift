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
    
    func shoot(direction: CGPoint, map: GameScene) {
        //let magicDistance = _magic.get("projectileDistance") as CGFloat
        //let magicSpeed = NSTimeInterval(_magic.get("projectileSpeed") as Float)
        let magicDistance = CGFloat(100)
        let magicSpeed = NSTimeInterval(0.3)
        
        let moveAction = moveActionInDirection(direction, distance: magicDistance, speed: magicSpeed)
        let moveForeverAction = SKAction.repeatActionForever(moveAction)
        runAction(moveForeverAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}