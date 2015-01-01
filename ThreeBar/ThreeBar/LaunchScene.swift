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
        let titleLabel = SKLabelNode(fontNamed: _magic.get("titleFont") as String)
        titleLabel.name = "titleLabel"
        titleLabel.text = _magic.get("titleText") as String
        titleLabel.fontSize = _magic.get("titleSize") as CGFloat
        titleLabel.color = UIColor.whiteColor()
        
        var bgSize = CGSize()
        //bgSize.width = titleLabel.frame.width * 1.3
        //bgSize.height = titleLabel.frame.width * 1.1
        bgSize.width = 300
        bgSize.height = 100
        
        let titleBg = SKSpriteNode(color: UIColor.orangeColor(), size: bgSize)
        
        titleBg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 70)
        titleBg.zPosition = 9998
        self.addChild(titleBg)

        titleLabel.position = CGPoint(x: CGRectGetMidX(titleBg.frame), y: CGRectGetMidY(titleBg.frame))
        titleLabel.zPosition = 9999
        titleBg.addChild(titleLabel)
    }
    
    func addStartButton() {
        let startButton = SKLabelNode(fontNamed: _magic.get("startButtonFont") as String)
        startButton.name = "startButton"
        startButton.text = _magic.get("startButtonText") as String
        startButton.fontSize = _magic.get("startButtonSize") as CGFloat
        startButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 175)
        
        self.addChild(startButton)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            // Start new game if start button is pressed
            let node = self.nodeAtPoint(touch.locationInNode(self))
            //if node.name == "startButton" {
            
            // Start new game if screen is touched at all
            if true {
                let skView = self.view! as SKView
                skView.ignoresSiblingOrder = true

                skView.showsFPS = true
                skView.showsNodeCount = true
                
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
                    
                    scene.lives = _magic.get("numLives") as Int
                    
                    skView.presentScene(scene)
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
