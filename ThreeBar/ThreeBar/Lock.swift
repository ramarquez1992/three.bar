//
//  Lock.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/21/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Lock: SKSpriteNode {
    var open = false
    
    init(position: CGPoint) {
        let width = _magic.get("lockWidth") as CGFloat
        let height = _magic.get("lockHeight") as CGFloat
        let color = UIColor.purpleColor()
        
        super.init(texture: nil, color: color, size: CGSize(width: width, height: height))

        self.position = position
        setPhysics()
    }
    
    func setPhysics() {
        let buffer: CGFloat = 15    // Make sure lock can be hit though placed on wall
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width + buffer, height: size.height + buffer))

        physicsBody?.categoryBitMask = PhysicsCategory.Lock
        
        physicsBody?.dynamic = true
        physicsBody?.allowsRotation = true
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.contactTestBitMask = PhysicsCategory.Laser
        physicsBody?.collisionBitMask = 0
    
    }
    
    func unlock() {
        open = true
        color = UIColor.greenColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}