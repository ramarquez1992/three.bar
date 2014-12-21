//
//  Unit.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/21/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: Actor {
    var moving = false  // Direction moving, or nil if not moving
    
    let animationFrames = [SKTexture]()
    let stillFrame = SKTexture()
    
    init(named: String) {
        let animationAtlas = SKTextureAtlas(named: "\(named)Frames")
        
        stillFrame = animationAtlas.textureNamed("\(named)1")
        
        for i in 2...animationAtlas.textureNames.count {    // Skip first forward facing image
            let texture = animationAtlas.textureNamed("\(named)\(i)")
            
            animationFrames.append(texture)
        }
        
        super.init(texture: stillFrame,
            color: nil,
            size: CGSize(width: _magic.get("\(named)Size") as CGFloat, height: _magic.get("\(named)Size") as CGFloat))
        
        
        name = named
    }
    
    func startMoving() {
        moving = true
        
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.2, resize: false, restore: true)
        runAction(SKAction.repeatActionForever(animationAction), withKey: "moveAnimation")
    }
    
    func stopMoving() {
        moving = false
        
        removeActionForKey("moveAnimation")
        texture = stillFrame
    }
    
    func move() {
        faceSprite()
        
        let magicDistance = _magic.get("\(name!)MoveDistance") as CGFloat
        let magicSpeed = NSTimeInterval(_magic.get("\(name!)MoveSpeed") as CGFloat)
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}