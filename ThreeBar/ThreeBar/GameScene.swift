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
    let door       = Door()
    var locks      = [Lock]()
    var score: Int = 0
    let scoreLabel = SKLabelNode()
    let livesLabel = SKLabelNode()
    var startTime  = NSDate()
    
    override func didMoveToView(view: SKView) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMotionShake:", name:"MotionShake", object: nil)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        addLivesLabel()
        addScoreLabel()
        
        addHero()
        addMoveControl()
        
        addHive()
        populateWithMobs()
        
        addDoor()
        populateWithLocks()
    }
    
    func addLivesLabel() {
        livesLabel.fontName = _magic.get("livesFont") as String
        livesLabel.name     = "livesLabel"
        
        livesLabel.text     = ""
        for var i = 0; i < lives; ++i {
            livesLabel.text = "\(livesLabel.text)_"
        }
        
        livesLabel.fontSize  = _magic.get("livesSize") as CGFloat
        livesLabel.position  = CGPoint(x: size.width - 100, y: 15)
        livesLabel.zPosition = CGFloat(ZIndex.HUD.rawValue)
        
        self.addChild(livesLabel)
    }
    
    func addScoreLabel() {
        scoreLabel.fontName  = _magic.get("scoreFont") as String
        scoreLabel.name      = "scoreLabel"
        scoreLabel.text      = String(score)
        scoreLabel.fontSize  = _magic.get("scoreSize") as CGFloat
        scoreLabel.position  = CGPoint(x: CGRectGetMidX(self.frame), y: 10)
        scoreLabel.zPosition = CGFloat(ZIndex.HUD.rawValue)

        
        self.addChild(scoreLabel)
    }
    
    func changeScore(changeBy: Int) {
        score += changeBy
        scoreLabel.text = String(score)
    }
    
    func addHero() {
        hero.position = getRandomPosition()
        
        addChild(hero)
    }
    
    func killHero() {
        hero.killLaser()
        hero.removeFromParent()
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
        spawnMob(getValidMobPosition())
    }
    
    func getValidMobPosition() -> CGPoint {
        var possiblePosition: CGPoint
        var valid = true
        var distance:CGFloat = 0
        
        do {
            possiblePosition = getRandomPosition(fromPoint: hero.position, minDistance: _magic.get("mobMinDistance") as CGFloat)
            valid = true
            
            for mob in mobs {
                distance = (mob.position - possiblePosition).length()
                
                if (distance <= (_magic.get("mobMinDistance") as CGFloat)) {
                    valid = false
                }
            }
            
        } while !valid
        
        return possiblePosition
    }

    
    func respawnMob(spawnPosition: CGPoint) {
        let beforeSpawnAction = SKAction.runBlock({ self.hive.color = UIColor.whiteColor() })
        let spawnAction = SKAction.runBlock({ self.spawnMob(spawnPosition) })
        let afterSpawnAction = SKAction.runBlock({ self.hive.color = UIColor.blackColor() })
        let waitAction = SKAction.waitForDuration(NSTimeInterval(_magic.get("mobRespawnTime") as Float))
        
        runAction(SKAction.sequence([ beforeSpawnAction, waitAction, spawnAction, afterSpawnAction ]))
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
    
    func addDoor() {
        door.position = CGPoint(x: size.width / 2, y: size.height)
        
        addChild(door)
    }
    
    func populateWithLocks() {
        for i in 1...2 {
            addLock()
        }
    }
    
    func addLock() {
        let lock = Lock(position: getValidLockPosition())

        locks.append(lock)
        addChild(lock)
    }
    
    func getValidLockPosition() -> CGPoint {
        var possiblePosition: CGPoint
        var valid = true
        var distance:CGFloat = 0
        
        do {
            possiblePosition = getPossibleLockPosition()
            valid = true
            
            for lock in locks {
                distance = (lock.position - possiblePosition).length()
                
                if (distance <= (_magic.get("lockMinDistance") as CGFloat)) {
                    valid = false
                }
            }
        
        } while !valid
        
        return possiblePosition
    }
    
    func getPossibleLockPosition() -> CGPoint {
        let randomPosition = getRandomPosition()
        var possiblePosition = CGPoint()
        
        let random = arc4random_uniform(4) + 1
        if random == 1 {             // Place on top
            possiblePosition = CGPoint(x: randomPosition.x, y: size.height)
        } else if random == 2 {      // Place on right
            possiblePosition = CGPoint(x: size.width, y: randomPosition.y)
        } else if random == 3 {      // Place on bottom
            possiblePosition = CGPoint(x: randomPosition.x, y: 0)
        } else {                    // Place on left
            possiblePosition = CGPoint(x: 0, y: randomPosition.y)
        }
        
        if checkIfInCorner(possiblePosition) || checkIfNearDoor(possiblePosition) {
            possiblePosition = getPossibleLockPosition()
        }
        
        return possiblePosition
    }
    
    func checkIfInCorner(possiblePosition: CGPoint) -> Bool {
        var inCorner = false
        let lockSize = _magic.get("lockWidth") as CGFloat
        
        let leftSide  = (possiblePosition.x < lockSize) && ((possiblePosition.y > (size.height - lockSize)) || (possiblePosition.y < lockSize))
        let rightSide = (possiblePosition.x > size.width - lockSize) && ((possiblePosition.y > (size.height - lockSize)) || (possiblePosition.y < lockSize))
        
        if leftSide || rightSide {
            inCorner = true
        }
        
        return inCorner
    }
    
    func checkIfNearDoor(possiblePosition: CGPoint) -> Bool {
        var nearDoor = false
        let distance = (door.position - possiblePosition).length()
        
        if (distance <= (_magic.get("doorMinDistance") as CGFloat)) {
            nearDoor = true
        }
        
        return nearDoor
    }
    
    func checkLocksAreOpen() -> Bool {
        for lock in locks {
            if !lock.open {
                return false
            }
        }
        
        return true
    }
    
    func addMoveControl() {
        let moveControl = SKSpriteNode(texture: SKTexture(imageNamed: _magic.get("controlImage") as String),
            color: UIColor.yellowColor(),
            size: CGSize(width: _magic.get("controlSize") as CGFloat, height: _magic.get("controlSize") as CGFloat))
        
        moveControl.position = CGPoint(x: _magic.get("controlCenter") as CGFloat, y: _magic.get("controlCenter") as CGFloat)
        
        moveControl.zPosition = CGFloat(ZIndex.MoveControl.rawValue)

        
        addChild(moveControl)
    }
    
    func getControlRelativeDirection(touchLocation: CGPoint) -> CGPoint {
        let controlCenter = CGPoint(x: _magic.get("controlCenter") as CGFloat, y: _magic.get("controlCenter") as CGFloat)
        
        return getRelativeDirection(controlCenter, destination: touchLocation)
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
    
    func heroDidCollideWithDoor() {
        if door.open {
            endgame()
        }
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
            door.unlock()
        }
    }
    
    func laserDidCollideWithDoor(laser: Laser, door: Door) {
        if !checkLocksAreOpen() {
            door.blink()
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
                    
                case PhysicsCategory.Door:
                    heroDidCollideWithDoor()
                    
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
                    
                case PhysicsCategory.Door:
                    laserDidCollideWithDoor(firstNode as Laser, door: secondNode as Door)
                    
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




