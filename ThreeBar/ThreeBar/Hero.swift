//
//  Hero.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: Unit {
    var canTeleport = false
    var teleportTimer = NSTimer()
    var laser: Laser? = nil
    
    init() {
        super.init(named: "hero")
        
        zPosition = CGFloat(ZIndex.Hero.rawValue)
        physicsBody?.categoryBitMask = PhysicsCategory.Hero
        
        teleportTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(_magic.get("heroTeleportTime") as Float), target: self, selector:Selector("allowTeleport"), userInfo: nil, repeats: true)
    }
    
    func teleport(map: GameScene) {
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
    
    func killLaser() {
        laser?.removeFromParent()
        laser = nil
    }
    
    func kill() {
        teleportTimer.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}