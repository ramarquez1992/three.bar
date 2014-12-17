//
//  GameScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/13/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let hero       = Hero()
    var mobs       = [Mob]()
    var score: Int = 0
    let scoreLabel = SKLabelNode()
    let startTime  = NSDate()
    
    override func didMoveToView(view: SKView) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMotionShake:", name:"MotionShake", object: nil)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        addHero()
        addScoreLabel()
        addMoveControl()
        
        populateWithMobs()
    }
    
    func addMoveControl() {
        let moveControl = SKSpriteNode(texture: SKTexture(imageNamed: _magic.controlImage),
            color: UIColor.yellowColor(),
            size: CGSize(width: CGFloat(_magic.heroSize), height: CGFloat(_magic.heroSize)))
        
        moveControl.position = CGPoint(x: CGFloat(_magic.controlCenter), y: CGFloat(_magic.controlCenter))
        
        addChild(moveControl)
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
    
    func changeScore(changeBy: Int) {
        score += changeBy
        scoreLabel.text = String(score)
    }
    
    func addScoreLabel() {
        scoreLabel.fontName = _magic.scoreFont
        scoreLabel.name     = "scoreLabel"
        scoreLabel.text     = String(score)
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
        hero.teleport(self)
    }
    
    func heroDidCollideWithMob(mob: Mob) {
        changeScore(100)
        
        mob.removeFromParent()
        
        var i = 0
        for inArray in mobs {
            if inArray == mob {
                mobs.removeAtIndex(i)
                
                if mobs.count == 0 {
                    endgame()
                }
            }
            
            ++i
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Put bodies in ascending PhysicsCategory order
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.Hero) != 0 {
            
            if (secondBody.categoryBitMask & PhysicsCategory.Mob) != 0 {
                //!! why did I not have to do this check when 
                //   testing on physical device??
                if let n = secondBody.node {
                    heroDidCollideWithMob(n as Mob)
                }
            }

        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if let location = hero.moving {
            hero.facing = location
            hero.move(location, map: self)
        }
    }
    
    func endgame() {
        if let scene = EndgameScene.unarchiveFromFile("EndgameScene") as? EndgameScene {
            let skView = self.view! as SKView
            
            scene.score = score
            scene.startTime = startTime
            
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

}




