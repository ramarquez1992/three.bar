//
//  Hero.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: Actor {
    var moving = false  // Direction moving, or nil if not moving
    var canTeleport = false
    var teleportTimer = NSTimer()
    var laser: Laser? = nil
    
    let animationFrames = [SKTexture]()
    
    init() {
        super.init(texture: SKTexture(imageNamed: _magic.get("heroSprite") as String),
            color: UIColor.yellowColor(),
            size: CGSize(width: _magic.get("heroSize") as CGFloat, height: _magic.get("heroSize") as CGFloat))
        
        zPosition = 1000  // Hero is always visible
        name = "heroNode"
        physicsBody?.categoryBitMask = PhysicsCategory.Hero
        
        teleportTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(_magic.get("heroTeleportTime") as Float), target: self, selector:Selector("allowTeleport"), userInfo: nil, repeats: true)

        //TODO: get name from magic plist???
        let animationAtlas = SKTextureAtlas(named: "HeroImages")
        for i in 2...animationAtlas.textureNames.count {    // Skip first forward facing image
            let texture = animationAtlas.textureNamed("hero\(i)")
            
            animationFrames.append(texture)
        }
    }
    
    func startMoving() {
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.2, resize: false, restore: true)
        runAction(SKAction.repeatActionForever(animationAction), withKey: "heroAnimation")
    }
    
    func stopMoving() {
        removeActionForKey("heroAnimation")
        texture = SKTexture(imageNamed: _magic.get("heroSprite") as String)
    }
    
    func move() {
        faceSprite()
        
        let magicDistance = _magic.get("heroMoveDistance") as CGFloat
        let magicSpeed = NSTimeInterval(_magic.get("heroMoveSpeed") as CGFloat)
        
        let moveAction = moveActionInDirection(facing, distance: magicDistance, speed: magicSpeed)
        runAction(moveAction)
    }
    
    // Point sprite in the correct direction
    func faceSprite() {
        if facing.x > 0 && xScale != -1 {
            xScale = -1
        } else if facing.x <= 0 && xScale != 1 {
            xScale = 1
        }
    }
    
    func teleport(map: GameScene) {
        //
        if canTeleport {
            position = map.getRandomPosition(fromPoint: position, minDistance: _magic.get("heroTeleportMinDistance") as CGFloat)
            canTeleport = false
        }
    }

    func shoot(map: GameScene) {
        if laser == nil && self.parent != nil {
            laser = Laser()
            laser?.position = position
            map.addChild(laser!)
            
            laser?.facing = facing
            
            flashScreen(UIColor.redColor(), screen: map)
            
            laser?.move()
        }
    }
    
    // Flash the screen with color
    func flashScreen(color: UIColor, screen: SKScene) {
        let flash = SKSpriteNode(texture: nil, color: color, size: screen.size)
        flash.position = CGPoint(x: screen.size.width / 2, y: screen.size.height / 2)
        flash.zPosition = 999  // Covers everything but the hero
        
        runAction(SKAction.sequence([
            SKAction.runBlock({ screen.addChild(flash) }),
            SKAction.waitForDuration(NSTimeInterval(_magic.get("flashDuration") as Float)),
            SKAction.runBlock({ flash.removeFromParent() })
            ]))
    }
    
    func allowTeleport() {
        canTeleport = true
    }
    
    func kill() {
        teleportTimer.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}