//
//  GameScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/13/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let heroNode = Hero()
    
    override func didMoveToView(view: SKView) {
        addHero()
    }
    
    func addHero() {
        //TODO: get valid random position
        heroNode.position = CGPoint(x: size.width * 0.8, y: size.height / 2)
        
        addChild(heroNode)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

}
