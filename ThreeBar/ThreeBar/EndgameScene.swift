//
//  EndgameScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/16/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class EndgameScene: SKScene {
    override func didMoveToView(view: SKView) {
        addTitle()
    }
    
    func addTitle() {
        let titleLabel = SKLabelNode(fontNamed: _magic.titleFont)
        titleLabel.name = "titleLabel"
        titleLabel.text = _magic.titleText
        titleLabel.fontSize = CGFloat(_magic.titleSize)
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 70)
        
        self.addChild(titleLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let node = self.nodeAtPoint(touch.locationInNode(self))
            
            // Start new game
            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                let skView = self.view! as SKView
                
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                
                skView.presentScene(scene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
