//
//  Mob.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/16/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Mob: Unit {
    init(position: CGPoint) {
        super.init(named: "mob", position: position)
        
        zPosition = CGFloat(ZIndex.Mob.rawValue)
        physicsBody?.categoryBitMask = PhysicsCategory.Mob

        //let tolerance = _magic.get("mobContactTolerance") as CGFloat
        //physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width + tolerance, height: size.height + tolerance))
        
        physicsBody?.contactTestBitMask = physicsBody!.contactTestBitMask - PhysicsCategory.Mob
    }
    
    func nextAction(map: GameScene) {
        moveTowardsHero(map)
    }
    
    func moveTowardsHero(map: GameScene) {
        facing = map.getRelativeDirection(position, destination: map.hero.position)
        
        if !moving {
            startMoving()
        }
        
        move()
    }
    
    func shoot(direction: CGPoint, map: GameScene) {
        //TODO: fire projectile
        
        //TODO: Play sound effect
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}