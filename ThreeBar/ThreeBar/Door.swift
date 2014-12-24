//
//  Door.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/23/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class Door: SKSpriteNode {
    var open = false
    
    override init() {
        let width = _magic.get("doorWidth") as CGFloat
        let height = _magic.get("doorHeight") as CGFloat
        let color = UIColor.redColor()
        
        super.init(texture: nil, color: color, size: CGSize(width: width, height: height))
        
        //self.position = position
        zPosition = CGFloat(ZIndex.Door.rawValue)
        setPhysics()
    }
    
    func setPhysics() {
        let tolerance = _magic.get("lockContactTolerance") as CGFloat
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width + tolerance, height: size.height + tolerance))
        
        physicsBody?.categoryBitMask = PhysicsCategory.Door
        
        physicsBody?.dynamic = true
        physicsBody?.allowsRotation = false
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.contactTestBitMask = PhysicsCategory.Laser + PhysicsCategory.Hero
        physicsBody?.collisionBitMask = 0
        
    }
    
    func unlock() {
        open = true
        color = UIColor.lightGrayColor()
    }
    
    func blink() {
        let originalColor = color
        
        let setColorAction = SKAction.runBlock({ self.color = UIColor.yellowColor() })
        let waitAction = SKAction.waitForDuration(NSTimeInterval(0.1))
        let resetColorAction = SKAction.runBlock({ self.color = originalColor })
        
        runAction(SKAction.sequence([ setColorAction, waitAction, resetColorAction ]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}