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
    var moving:CGPoint? = nil  // Direction moving, or nil if not moving
    var canTeleport = false
    
    init() {
        super.init(texture: SKTexture(imageNamed: _magic.get("heroSprite") as String),
            color: UIColor.yellowColor(),
            size: CGSize(width: _magic.get("heroSize") as CGFloat, height: _magic.get("heroSize") as CGFloat))
        
        zPosition = 1000  // Hero is always visible
        name = "heroNode"
        physicsBody?.categoryBitMask = PhysicsCategory.Hero
        
        let teleportTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(_magic.get("heroTeleportTime") as Float), target: self, selector:Selector("allowTeleport"), userInfo: nil, repeats: true)

    }
    
    func move(location: CGPoint, map: GameScene) {
        // Get center point of left side of screen
        //let controlCenter = CGPoint(x: (map.size.width / 2) / 2, y: map.size.height / 2)
        let controlCenter = CGPoint(x: _magic.get("controlCenter") as CGFloat, y: _magic.get("controlCenter") as CGFloat)
        
        // Calculate azimuth of location from center
        let magicDistance = _magic.get("heroMoveDistance") as CGFloat
        let newLocation = ((location - controlCenter).normalized() * magicDistance) + position
        
        // Using moveTo() rather than manually updating position for smoother animation
        let moveAction = SKAction.moveTo(newLocation, duration: NSTimeInterval(_magic.get("heroMoveSpeed") as Float))
        runAction(moveAction)
    }
    
    func teleport(map: GameScene) {
        //
        if canTeleport {
            position = map.getRandomPosition(fromPoint: position, minDistance: _magic.get("heroTeleportMinDistance") as CGFloat)
            canTeleport = false
        }
    }

    func shoot(direction: CGPoint, map: GameScene) {
        let disc = Projectile()
        disc.position = position
        map.addChild(disc)
        disc.move(facing, map: map)
        
        flashScreen(UIColor.redColor(), screen: map)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}