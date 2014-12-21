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
    init() {
        super.init(named: "mob")
        
        zPosition = 800  // Below hero
        physicsBody?.categoryBitMask = PhysicsCategory.Mob

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