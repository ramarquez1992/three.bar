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
        addTitle()
        addStartButton()
    }
    
    func addTitle() {
        let titleLabel = SKLabelNode(fontNamed:"Way beyond blue")
        titleLabel.name = "titleLabel"
        titleLabel.text = "4BAR";
        titleLabel.fontSize = 200;
        titleLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 70);
        
        self.addChild(titleLabel)
    }
    
    func addStartButton() {
        let startButton = SKLabelNode(fontNamed:"Masaaki")
        startButton.name = "startButton"
        startButton.text = "START";
        startButton.fontSize = 65;
        startButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 175);
        
        self.addChild(startButton)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let node = self.nodeAtPoint(touch.locationInNode(self))
            
            // Start new game when start button is pressed
            if node.name == "startButton" {
                if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                    let skView = self.view! as SKView
                    
                    //skView.showsFPS = true
                    //skView.showsNodeCount = true
                    
                    skView.ignoresSiblingOrder = true
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
