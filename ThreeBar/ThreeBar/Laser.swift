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
        
        zPosition = CGFloat(ZIndex.Laser.rawValue)
        name = "laserNode"
        physicsBody?.categoryBitMask = PhysicsCategory.Laser
        
    }
    
    
    func move() {
        let magicDistance = _magic.get("projectileDistance") as CGFloat
        let magicSpeed = NSTimeInterval(_magic.get("projectileSpeed") as Float)
        
        let moveAction = moveActionInDirection(facing, distance: magicDistance, speed: magicSpeed)
        runAction(moveAction)
    }
    
    func comeBack(hero: Hero) {
        physicsBody?.categoryBitMask = PhysicsCategory.ReturnLaser
        texture = SKTexture(imageNamed: _magic.get("laserBackSprite") as String)
        
        moveBack(hero)
    }
    
    func moveBack(hero: Hero) {
        facing = (hero.position - position).normalized()
        
        move()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}