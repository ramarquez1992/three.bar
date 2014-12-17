//
//  EndgameScene.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/16/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import SpriteKit

class EndgameScene: SKScene {
    var score: Int!
    var startTime: NSDate!
    
    override func didMoveToView(view: SKView) {
        addTitle()
        addScore()
        addTime()
    }
    
    func addTitle() {
        let titleLabel = SKLabelNode(fontNamed: _magic.titleFont)
        titleLabel.name = "titleLabel"
        titleLabel.text = _magic.endgameTitleText
        titleLabel.fontSize = CGFloat(_magic.endgameTitleSize)
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(titleLabel)
    }
    
    
    func addScore() {
        let scoreLabel = SKLabelNode(fontNamed: _magic.endgameScoreFont)
        scoreLabel.name = "scoreLabel"
        scoreLabel.text = String(score)
        scoreLabel.fontSize = CGFloat(_magic.endgameScoreSize)
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 200)
        
        self.addChild(scoreLabel)
    }
    
    
    func addTime() {
        let timeLabel = SKLabelNode(fontNamed: _magic.endgameTimeFont)
        timeLabel.name = "timeLabel"
        
        var currentTime = NSDate()
        var difference = currentTime.timeIntervalSince1970 - startTime.timeIntervalSince1970
        
        var minutesRaw = Int(difference / 60)
        var secondsRaw = Int(difference % 60)
        
        var minutes = String(minutesRaw)
        var seconds = String(secondsRaw)
        
        if minutesRaw < 10 { minutes = "0\(minutes)" }
        if secondsRaw < 10 { seconds = "0\(seconds)" }
        
        timeLabel.text = "\(minutes):\(seconds)"
        
        timeLabel.fontSize = CGFloat(_magic.endgameTimeSize)
        timeLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 150)
        
        self.addChild(timeLabel)
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
