//
//  OnboardingScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class OnboardingScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addMoveLabel()
        addShootLabel()
    }
    
    func addMoveLabel() {
        let moveLabel = SKLabelNode(fontNamed:_magic.onboardingFont)
        moveLabel.name = "moveLabel"
        moveLabel.text = _magic.onboardingMoveText
        moveLabel.fontSize = CGFloat(_magic.onboardingSize)
        moveLabel.position = CGPoint(x:CGRectGetMidX(self.frame) / 2,
            y:CGRectGetMidY(self.frame))
        
        self.addChild(moveLabel)
    }
    
    func addShootLabel() {
        let shootLabel = SKLabelNode(fontNamed:_magic.onboardingFont)
        shootLabel.name = "shootLabel"
        shootLabel.text = _magic.onboardingShootText
        shootLabel.fontSize = CGFloat(_magic.onboardingSize)
        shootLabel.position = CGPoint(x:CGRectGetMidX(self.frame) + CGRectGetMidX(self.frame) / 2,
            y:CGRectGetMidY(self.frame))
        
        self.addChild(shootLabel)
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
