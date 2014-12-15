//
//  LaunchScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class LaunchScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        createTitle()
        createStartButton()
    }
    
    func createTitle() {
        let titleLabel = SKLabelNode(fontNamed:"Way beyond blue")
        titleLabel.name = "titleLabel"
        titleLabel.text = "4Bar";
        titleLabel.fontSize = 200;
        titleLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 70);
        
        self.addChild(titleLabel)
    }
    
    func createStartButton() {
        let startButton = SKLabelNode(fontNamed:"Masaaki")
        startButton.name = "startButton"
        startButton.text = "START";
        startButton.fontSize = 65;
        startButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 175);
        
        self.addChild(startButton)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let node = self.nodeAtPoint(touch.locationInNode(self))
            
            if node.name == "startButton" {
                if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                    // Configure the view.
                    let skView = self.view! as SKView
                    skView.showsFPS = true
                    skView.showsNodeCount = true
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    skView.ignoresSiblingOrder = true
                    
                    /* Set the scale mode to scale to fit the window */
                    scene.scaleMode = .AspectFill
                    
                    skView.presentScene(scene)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
