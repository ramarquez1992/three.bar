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
        addScoreLabel()
    }
    
    func addHero() {
        // Position hero at random point on map
        let xPos = CGFloat(size.width) * (CGFloat(arc4random()) / CGFloat(UInt32.max))
        let yPos = CGFloat(size.height) * (CGFloat(arc4random()) / CGFloat(UInt32.max))
        hero.position = CGPoint(x: xPos, y: yPos)
        
        addChild(hero)
    }
    
    func addScoreLabel() {
        let scoreLabel = SKLabelNode(fontNamed:"Masaaki")
        scoreLabel.name = "scoreLabel"
        scoreLabel.text = "0007300";
        scoreLabel.fontSize = 50;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:10);
        
        self.addChild(scoreLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Shoot if right side touched
            if location.x > size.width / 2 {
                hero.shoot(location, map: self)
            }

        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Continuously move hero if touch is held on left side
            if location.x < size.width / 2 {
                let moveAction = SKAction.moveTo(location, duration: NSTimeInterval(0.1))
                hero.runAction(moveAction)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}




