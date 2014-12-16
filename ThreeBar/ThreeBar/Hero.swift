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
        super.init(texture: SKTexture(imageNamed: "hero"),
            color: UIColor.yellowColor(),
            size: CGSize(width: 100.0, height: 100.0))
        
        zPosition = 1000  // Hero is always visible
        name = "heroNode"
        
        let teleportTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector:Selector("allowTeleport"), userInfo: nil, repeats: true)

    }
    
    func move(location: CGPoint, map: GameScene) {
        // Get center point of left side of screen
        let controlCenter = CGPoint(x: (map.size.width / 2) / 2, y: map.size.height / 2)
        
        // Calculate azimuth of location from center
        let magicDistance = CGFloat(30)
        let newLocation = ((location - controlCenter).normalized() * magicDistance) + position
        
        // Using moveTo() rather than manually updating position for smoother animation
        let moveAction = SKAction.moveTo(newLocation, duration: NSTimeInterval(0.05))
        runAction(moveAction)
    }

    func shoot(direction: CGPoint, map: GameScene) {
        //TODO: fire projectile
        
        //TODO: Play sound effect
        
        flashScreen(UIColor.redColor(), screen: map)
    }
    
    // Flash the screen with color
    func flashScreen(color: UIColor, screen: SKScene) {
        let flash = SKSpriteNode(texture: nil, color: color, size: screen.size)
        flash.position = CGPoint(x: screen.size.width / 2, y: screen.size.height / 2)
        flash.zPosition = 999  // Covers everything but the hero
        
        runAction(SKAction.sequence([
            SKAction.runBlock({ screen.addChild(flash) }),
            SKAction.waitForDuration(0.03),
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