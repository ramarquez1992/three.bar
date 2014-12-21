//
//  Explosion.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/21/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Explosion: SKSpriteNode {
    let animationFrames = [SKTexture]()
    
    init(node: SKSpriteNode) {
        let magicMultiplier = _magic.get("explosionSize") as CGFloat
        var newSize = node.size
        newSize.height = node.size.height * magicMultiplier
        newSize.width = node.size.width * magicMultiplier
        
        super.init(texture: nil, color: nil, size: newSize)
        
        position = node.position
        zPosition = 1100
        
        //TODO: get name from magic plist???
        let animationAtlas = SKTextureAtlas(named: "explosionFrames")
        for i in 1...animationAtlas.textureNames.count {
            let texture = animationAtlas.textureNamed("explosion\(i)")
            
            animationFrames.append(texture)
        }
    }

    func getAnimation() -> SKAction {
        let duration = NSTimeInterval(_magic.get("explosionDuration") as CGFloat)
        
        let animationAction = SKAction.animateWithTextures(animationFrames, timePerFrame: duration)
        
        return animationAction
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}