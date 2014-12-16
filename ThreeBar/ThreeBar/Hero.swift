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
    init() {
        super.init(texture: SKTexture(imageNamed: "hero"),
            color: UIColor.yellowColor(),
            size: CGSize(width: 100.0, height: 100.0))
        
        zPosition = 1000  // Hero is always visible
        name = "heroNode"
    }
    
    func move(location: CGPoint, map: GameScene) {
        //get center point of left side of screen
        
        //calculate azimuth of location from center
        
        let magicDistance = 1
        //set newLocation to currentLocation+magicDistance in direction of azimuth
        let newLocation = location
        
        
        let magicSpeed = NSTimeInterval(0.1)
        
        let moveAction = SKAction.moveTo(newLocation, duration: magicSpeed)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}