//
//  GameScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/13/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var lives: Int = 0
    let hero       = Hero()
    let hive       = Hive()
    var mobs       = [Mob]()
    var locks      = [Lock]()
    var score: Int = 0
    let scoreLabel = SKLabelNode()
    let livesLabel = SKLabelNode()
    var startTime  = NSDate()
    
    override func didMoveToView(view: SKView) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMotionShake:", name:"MotionShake", object: nil)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        addHero()
        addScoreLabel()
        addLivesLabel()
        addMoveControl()
        
        addHive()
        populateWithMobs()
        populateWithLocks()
    }
    
    func addMoveControl() {
        let moveControl = SKSpriteNode(texture: SKTexture(imageNamed: _magic.get("controlImage") as String),
            color: UIColor.yellowColor(),
            size: CGSize(width: _magic.get("heroSize") as CGFloat, height: _magic.get("heroSize") as CGFloat))
        
        moveControl.position = CGPoint(x: _magic.get("controlCenter") as CGFloat, y: _magic.get("controlCenter") as CGFloat)
        
        addChild(moveControl)
    }
    

    func getRandomPosition(fromPoint: CGPoint = CGPoint(), minDistance: CGFloat = 0.0) -> CGPoint {
        var possiblePosition: CGPoint
        var possibleLength: CGFloat
        var currentLength = fromPoint.length()
        var distance: CGFloat = 0.0
        
        do {
            possiblePosition = CGPoint(x: CGFloat(size.width) * (CGFloat(arc4random()) / CGFloat(UInt32.max)),
                y: CGFloat(size.height) * (CGFloat(arc4random()) / CGFloat(UInt32.max)))
            
            possibleLength = possiblePosition.length()
            distance = abs(currentLength - possibleLength)
        } while distance < CGFloat(minDistance)
        
        return possiblePosition
    }
    
    func addHero() {
        hero.position = getRandomPosition()
        
        addChild(hero)
    }
    
    func addHive() {
        hive.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        addChild(hive)
    }
    
    func populateWithMobs() {
        for i in 1...3 {
            spawnMob()
        }
        
    }
    
    func spawnMob(spawnPosition: CGPoint) {
        let mob = Mob(position: spawnPosition)

        mobs.append(mob)
        addChild(mob)
    }
    
    func spawnMob() {
        let mobPosition = getRandomPosition(fromPoint: hero.position, minDistance: _magic.get("mobMinDistance") as CGFloat)

        spawnMob(mobPosition)
    }
    
    func respawnMob(spawnPosition: CGPoint) {
        let beforeSpawnAction = SKAction.runBlock({ self.hive.color = UIColor.whiteColor() })
        let spawnAction = SKAction.runBlock({ self.spawnMob(spawnPosition) })
        let afterSpawnAction = SKAction.runBlock({ self.hive.color = UIColor.blackColor() })
        let waitAction = SKAction.waitForDuration(NSTimeInterval(_magic.get("mobRespawnTime") as Float))
        
        runAction(SKAction.sequence([ beforeSpawnAction, waitAction, spawnAction, afterSpawnAction ]))
    }
    
    func populateWithLocks() {
        let l1 = Lock()
        l1.position = getRandomPosition(fromPoint: hero.position, minDistance: _magic.get("mobMinDistance") as CGFloat)
        
        locks.append(l1)
        
        for lock in locks {
            addChild(lock)
        }
    }
    
    func changeScore(changeBy: Int) {
        score += changeBy
        scoreLabel.text = String(score)
    }
    
    func addScoreLabel() {
        scoreLabel.fontName = _magic.get("scoreFont") as String
        scoreLabel.name     = "scoreLabel"
        scoreLabel.text     = String(score)
        scoreLabel.fontSize = _magic.get("scoreSize") as CGFloat
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 10)
        
        self.addChild(scoreLabel)
    }
    
    func addLivesLabel() {
        livesLabel.fontName = _magic.get("livesFont") as String
        livesLabel.name     = "livesLabel"
        
        livesLabel.text     = ""
        for var i = 0; i < lives; ++i {
            livesLabel.text = "\(livesLabel.text)_"
        }
        
        livesLabel.fontSize = _magic.get("livesSize") as CGFloat
        livesLabel.position = CGPoint(x: size.width - 100, y: 15)
        
        self.addChild(livesLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Move if left side touched
            if location.x < size.width / 2 {
                hero.facing = getControlRelativeDirection(location)
                hero.startMoving()
            } else {
                // Shoot if right side touched
                hero.shoot(self)
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Stop moving hero when control no longer held
            if location.x < size.width / 2 {
                hero.stopMoving()
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            // Continuously move hero if touch is held on left side
            if location.x < size.width / 2 {
                hero.facing = getControlRelativeDirection(location)
            }
        }
    }
    
    // Teleport hero on shake
    func onMotionShake(notification: NSNotification) {
        hero.teleport(self)
    }
    
    func getControlRelativeDirection(touchLocation: CGPoint) -> CGPoint {
        let controlCenter = CGPoint(x: _magic.get("controlCenter") as CGFloat, y: _magic.get("controlCenter") as CGFloat)
        
        return getRelativeDirection(controlCenter, destination: touchLocation)
    }
    
    func getRelativeDirection(origin: CGPoint, destination: CGPoint) -> CGPoint {
        let facingDirection = (destination - origin).normalized()
        
        return facingDirection
    }
    
    func heroDidCollideWithMob(mob: Mob) {        
        let explosion = Explosion(node: hero)
        
        killHero()
        addChild(explosion)
        
        let endAction = SKAction.runBlock({
            explosion.removeFromParent()
            --self.lives
            self.endgame()
        })
        
        explosion.runAction(SKAction.sequence([ explosion.getAnimation(), endAction ]))

    }
    
    func laserDidCollideWithHero() {
        hero.killLaser()
    }
    
    func laserDidCollideWithMob(laser: Laser, mob: Mob) {
        laser.comeBack(hero)

        let explosion = Explosion(node: mob)
        
        killMob(mob)
        addChild(explosion)
        
        let endExplosionAction = SKAction.runBlock({
            explosion.removeFromParent()
        })
        
        explosion.runAction(SKAction.sequence([ explosion.getAnimation(), endExplosionAction ]))
        
        respawnMob(hive.position)

    }
    
    func laserDidCollideWithWall(laser: Laser) {
        laser.comeBack(hero)
    }
    
    func laserDidCollideWithLock(laser: Laser, lock: Lock) {
        laser.comeBack(hero)
        lock.unlock()
        
        if checkLocksAreOpen() {
            endgame()
        }
    }
    
    func checkLocksAreOpen() -> Bool {
        for lock in locks {
            if !lock.open {
                return false
            }
        }
        
        return true
    }
    
    func killHero() {
        hero.killLaser()
        hero.removeFromParent()
    }
    
    func killMob(mob: Mob) {
        mob.removeFromParent()
        
        var i = 0
        for inArray in mobs {
            if inArray == mob {
                mobs.removeAtIndex(i)
                
                changeScore(100)
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
        
        // First, ensure both nodes are valid
        switch (firstBody.node?, secondBody.node?) {
        case let (.Some(firstNode), .Some(secondNode)):
            
            switch firstBody.categoryBitMask {
                
            case PhysicsCategory.Hero:
                switch secondBody.categoryBitMask {
                case PhysicsCategory.Mob:
                    heroDidCollideWithMob(secondNode as Mob)
                    
                case PhysicsCategory.ReturnLaser:
                    laserDidCollideWithHero()
                    
                default:
                    break
                }
                
            case PhysicsCategory.Mob:
                switch secondBody.categoryBitMask {
                case PhysicsCategory.Laser:
                    laserDidCollideWithMob(secondNode as Laser, mob: firstNode as Mob)
                    
                default:
                    break
                }
                
            case PhysicsCategory.Wall:
                switch secondBody.categoryBitMask {
                case PhysicsCategory.Laser:
                    laserDidCollideWithWall(secondNode as Laser)
                    
                default:
                    break
                }
                
            case PhysicsCategory.Laser:
                switch secondBody.categoryBitMask {
                case PhysicsCategory.Lock:
                    laserDidCollideWithLock(firstNode as Laser, lock: secondNode as Lock)
                    
                default:
                    break
                }
                
            default:
                break
            }

            
        default:
            break
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        for mob in mobs {
            mob.nextAction(self)
        }
        
        if hero.moving {
            hero.move()
        }
        
        if let heroLaser = hero.laser {
            switch heroLaser.physicsBody!.categoryBitMask {
            case PhysicsCategory.Laser:
                heroLaser.move()
                
            case PhysicsCategory.ReturnLaser:
                heroLaser.moveBack(hero)
                
            default:
                break
            }
        }
    }
    
    func endgame() {
        hero.kill()
        
        if lives >= 0 {
            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                if let skView = self.view {
                    scene.score = score
                    scene.lives = lives
                    scene.startTime = startTime
                    
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .AspectFill
                    
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    
                    skView.presentScene(scene)
                }
            }
        } else {
            if let scene = EndgameScene.unarchiveFromFile("EndgameScene") as? EndgameScene {
                if let skView = self.view {
                    scene.score = score
                    scene.startTime = startTime
                    
                    skView.ignoresSiblingOrder = true
                    scene.scaleMode = .AspectFill
                    
                    skView.presentScene(scene)
                }
            }
        }
    }

}




