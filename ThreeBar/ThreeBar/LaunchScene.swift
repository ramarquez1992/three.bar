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
        let titleLabel = SKLabelNode(fontNamed: _magic.titleFont)
        titleLabel.name = "titleLabel"
        titleLabel.text = _magic.titleText
        titleLabel.fontSize = CGFloat(_magic.titleSize)
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 70)
        
        self.addChild(titleLabel)
    }
    
    func addStartButton() {
        let startButton = SKLabelNode(fontNamed: _magic.startButtonFont)
        startButton.name = "startButton"
        startButton.text = _magic.startButtonText
        startButton.fontSize = CGFloat(_magic.startButtonSize)
        startButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 175)
        
        self.addChild(startButton)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let node = self.nodeAtPoint(touch.locationInNode(self))
            
            // Start new game when start button is pressed
            if node.name == "startButton" {
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true

                //skView.showsFPS = true
                //skView.showsNodeCount = true
                
                // Present onboarding scene on first run
                //NSUserDefaults.standardUserDefaults().removeObjectForKey("firstRun")
                if NSUserDefaults.standardUserDefaults().objectForKey("firstRun") == nil {
                    // OnboardingScene
                    if let scene = OnboardingScene.unarchiveFromFile("OnboardingScene") as? OnboardingScene {
                        scene.scaleMode = .AspectFill
                        skView.presentScene(scene)
                    }
                    
                    NSUserDefaults.standardUserDefaults().setObject(false, forKey: "firstRun")
                } else if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
                    // GameScene
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
