//
//  Explosion.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/21/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

//
//  Actor.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Explosion: SKSpriteNode {
    let animationFrames = [SKTexture]()
    
    init(size: CGSize) {
        let magicMultiplier: CGFloat = 0.7
        var newSize = size
        newSize.height = size.height * magicMultiplier
        newSize.width = size.width * magicMultiplier
        
        println(newSize)
        
        super.init(texture: nil, color: nil, size: newSize)
        zPosition = 1100
        
        //TODO: get name from magic plist???
        let animationAtlas = SKTextureAtlas(named: "ExplosionImages")
        for i in 1...animationAtlas.textureNames.count {    // Skip first forward facing image
            let texture = animationAtlas.textureNamed("explosion\(i)")
            
            animationFrames.append(texture)
        }
    }

    func getAnimation() -> SKAction {
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: 0.2, resize: false, restore: true)
        let endAction = SKAction.runBlock({ self.removeFromParent() })
        
        return SKAction.sequence([ animationAction, endAction ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}