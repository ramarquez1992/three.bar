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
        var bgSize = CGSize()
        bgSize.width = _magic.get("titleBgWidth") as CGFloat
        bgSize.height = _magic.get("titleBgHeight") as CGFloat
        
        let bgColor = UIColor(hex: _magic.get("titleBgColor") as String)
        
        let titleBg = SKSpriteNode(color: bgColor, size: bgSize)
        titleBg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 95)
        titleBg.zRotation = DEGREES_TO_RADIANS(_magic.get("titleRotation") as CGFloat)
        titleBg.zPosition = 9998
        self.addChild(titleBg)
        
        var rotateSequence = SKAction.sequence([
            SKAction.rotateByAngle(
                DEGREES_TO_RADIANS(_magic.get("titleBgRotation") as CGFloat),
                duration: NSTimeInterval(_magic.get("titleBgRotationDuration") as CGFloat)
            ),
            SKAction.rotateByAngle(
                DEGREES_TO_RADIANS(_magic.get("titleBgRotation") as CGFloat * -1),
                duration: NSTimeInterval(_magic.get("titleBgRotationDuration") as CGFloat)
            )
            ])
        var rotateForever = SKAction.repeatActionForever(rotateSequence)
        titleBg.runAction(rotateForever)
        
        let titleLabel = SKLabelNode(fontNamed: _magic.get("titleFont") as String)
        titleLabel.name = "titleLabel"
        titleLabel.text = _magic.get("titleText") as String
        titleLabel.fontSize = _magic.get("titleSize") as CGFloat
        titleLabel.fontColor = UIColor.blackColor()
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 45)
        titleLabel.zPosition = 9999
        self.addChild(titleLabel)

    }
    
    func addStartButton() {
        let startButton = SKLabelNode(fontNamed: _magic.get("startButtonFont") as String)
        startButton.name = "startButton"
        startButton.text = _magic.get("startButtonText") as String
        startButton.fontSize = _magic.get("startButtonSize") as CGFloat
        startButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 200)
        
        self.addChild(startButton)
        
        var scaleSequence = SKAction.sequence([
            SKAction.waitForDuration(5),
            SKAction.scaleTo(_magic.get("startButtonScale") as CGFloat,
                duration: NSTimeInterval(_magic.get("startButtonScaleDuration") as CGFloat)
            ),
            SKAction.scaleTo(1, duration: NSTimeInterval(_magic.get("startButtonScaleDuration") as CGFloat))
            ])
        var scaleForever = SKAction.repeatActionForever(scaleSequence)
        startButton.runAction(scaleForever)
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
