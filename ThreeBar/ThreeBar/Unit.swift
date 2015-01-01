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
    var angle: CGFloat = 0
    
    let frontFrames = [SKTexture]()
    let sideFrames = [SKTexture]()
    let backFrames = [SKTexture]()
    
    init(named: String, position: CGPoint = CGPointZero) {
        let animationAtlas = SKTextureAtlas(named: "\(named)Frames")
        
        
        for i in 1...(animationAtlas.textureNames.count / 3) {    // Forward, side, and back animations
            frontFrames.append(animationAtlas.textureNamed("\(named)-front\(i)"))
            sideFrames.append(animationAtlas.textureNamed("\(named)-side\(i)"))
            backFrames.append(animationAtlas.textureNamed("\(named)-back\(i)"))
        }
        
        super.init(texture: frontFrames[0],
            color: nil,
            size: CGSize(width: _magic.get("\(named)Size") as CGFloat, height: _magic.get("\(named)Size") as CGFloat),
            position: position)
        
        
        name = named
    }
    
    func startMoving() {
        moving = true
        startAnimation(getDirection(angle))
    }
    
    func stopMoving() {
        moving = false
        stopAnimation()
    }
    
    func getAngle(facing: CGPoint) -> CGFloat {
        var angle: CGFloat
        
        angle = CGFloat(atan2f(Float(facing.x), Float(facing.y)))
        angle = RADIANS_TO_DEGREES(angle)
        
        return angle
    }
    
    func getDirection(angle: CGFloat) -> Direction {
        var direction: Direction
        
        if angle >= 135 || angle <= -135 {
            direction = Direction.Down
        } else if angle >= 45 && angle <= 135 {
            direction = Direction.Right
        } else if angle <= -45 && angle >= -135 {
            direction = Direction.Left
        } else {
            direction = Direction.Up
        }
        
        return direction
    }
    
    func startAnimation(direction: Direction) {
        var animation: [SKTexture]
        
        switch direction {
        case .Up:
            animation = backFrames
            
        case .Right, .Left:
            animation = sideFrames
            
        default:
            animation = frontFrames
        }
        
        let animationAction = SKAction.animateWithTextures(animation, timePerFrame: 0.15, resize: false, restore: true)
        runAction(SKAction.repeatActionForever(animationAction), withKey: "moveAnimation")
    }
    
    func startAnimation() {
        startAnimation(.Down)
    }
    
    func stopAnimation() {
        removeActionForKey("moveAnimation")
        texture = frontFrames[0]    //TODO: use appropriate still-frame
    }
    
    func move() {
        let oldAngle = angle
        let oldAngleDirection = getDirection(oldAngle)
        
        angle = getAngle(facing)
        let angleDirection = getDirection(angle)
        
        if angleDirection != oldAngleDirection {
            stopAnimation()
            startAnimation(angleDirection)
        }
        
        
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