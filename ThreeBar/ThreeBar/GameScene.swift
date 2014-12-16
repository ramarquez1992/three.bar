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
    var mobs = [Mob]()
    
    override func didMoveToView(view: SKView) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMotionShake:", name:"MotionShake", object: nil)
        physicsWorld.contactDelegate = self
        
        addHero()
        addScoreLabel()
        
        populateWithMobs()
    }
    
    func getRandomPosition() -> CGPoint {
        let x = CGFloat(size.width) * (CGFloat(arc4random()) / CGFloat(UInt32.max))
        let y = CGFloat(size.height) * (CGFloat(arc4random()) / CGFloat(UInt32.max))
        
        return CGPoint(x: x, y: y)
    }
    
    func addHero() {
        hero.position = getRandomPosition()
        
        addChild(hero)
    }
    
    func populateWithMobs() {
        let m1 = Mob()
        m1.position = getRandomPosition()
        
        let m2 = Mob()
        m2.position = getRandomPosition()
        
        let m3 = Mob()
        m3.position = getRandomPosition()
        
        mobs.append(m1)
        mobs.append(m2)
        mobs.append(m3)
        
        for mob in mobs {
            addChild(mob)
        }
    }
    
    func addScoreLabel() {
        let scoreLabel      = SKLabelNode(fontNamed: _magic.scoreFont)
        scoreLabel.name     = "scoreLabel"
        scoreLabel.text     = "0007300"
        scoreLabel.fontSize = CGFloat(_magic.scoreSize)
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 10)
        
        self.addChild(scoreLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Move if left side touched
            if location.x < size.width / 2 {
                hero.moving = location
            } else {
                // Shoot if right side touched
                hero.shoot(location, map: self)
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Stop moving hero when control no longer held
            if location.x < size.width / 2 {
                hero.moving = nil
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Continuously move hero if touch is held on left side
            if location.x < size.width / 2 {
                hero.moving = location
            }
        }
    }
    
    // Teleport hero on shake
    func onMotionShake(notification: NSNotification) {
        if hero.canTeleport {
            hero.position = getRandomPosition()
            hero.canTeleport = false
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if let location = hero.moving {
            hero.facing = location
            hero.move(location, map: self)
        }
    }

}




