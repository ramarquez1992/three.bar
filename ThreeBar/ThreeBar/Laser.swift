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
        physicsBody?.categoryBitMask = PhysicsCategory.Laser
        
    }
    
    func comeBack(hero: Hero, map: GameScene) {
        texture = SKTexture(imageNamed: _magic.get("laserBackSprite") as String)
        
        let moveAction = moveBack(hero, map: map)
        let removeAction = SKAction.runBlock({
            //self.removeFromParent()
            println("removeAction")
        })
        
        runAction(
            SKAction.sequence([
                moveAction,
                removeAction
                ]))
    }
    
    func moveBack(hero: Hero, map: GameScene) -> SKAction {
        let magicDistance = _magic.get("projectileDistance") as CGFloat // Make sure projectile goes as far as it can
        let newLocation = (hero.position.normalized() * magicDistance) + position
        
        let moveAction = SKAction.runBlock({
            self.position = CGPoint(x: 50, y: 50) + self.position
        })
        
        //let repeatMoveAction = SKAction.repeatActionForever(moveAction)
        
        return moveAction
        //return repeatMoveAction
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}