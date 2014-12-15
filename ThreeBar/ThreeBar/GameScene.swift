//
//  GameScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/13/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let hero = Hero()
    
    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        
        addHero()
    }
    
    func addHero() {
        //TODO: get valid random position
        hero.position = CGPoint(x: size.width * 0.8, y: size.height / 2)
        
        addChild(hero)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

            let moveAction = SKAction.moveTo(location, duration: NSTimeInterval(1))
            
            hero.runAction(moveAction)
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}
