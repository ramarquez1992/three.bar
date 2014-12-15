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
    
    func shoot(direction: CGPoint, map: GameScene) {
        //TODO: fire projectile
        
        //TODO: Play sound effect
        
        // Flash entire screen
        let flash = SKSpriteNode(texture: nil, color: UIColor.redColor(), size: map.size)
        flash.position = CGPoint(x: map.size.width / 2, y: map.size.height / 2)
        flash.zPosition = 999  // Covers everything but the hero
        
        runAction(SKAction.sequence([
            SKAction.runBlock({ map.addChild(flash) }),
            SKAction.waitForDuration(0.03),
            SKAction.runBlock({ flash.removeFromParent() })
            ]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}