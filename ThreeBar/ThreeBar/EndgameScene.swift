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
    var titleLabel = SKLabelNode()
    
    
    override func didMoveToView(view: SKView) {
        addTitle()
        addScore()
        addTime()
        
    }
    
    func blink() {
        titleLabel.fontColor = getRandomColor()
    }
    
    func getRandomColor() -> UIColor {
        var randomRed    = CGFloat(drand48())
        var randomGreen  = CGFloat(drand48())
        var randomBlue   = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func addTitle() {
        titleLabel.fontName = _magic.get("titleFont") as String
        titleLabel.name = "titleLabel"
        titleLabel.text = _magic.get("endgameTitleText") as String
        titleLabel.fontSize = _magic.get("endgameTitleSize") as CGFloat
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(titleLabel)
    }
    
    
    func addScore() {
        let scoreLabel = SKLabelNode(fontNamed: _magic.get("endgameScoreFont") as String)
        scoreLabel.name = "scoreLabel"
        scoreLabel.text = String(score)
        scoreLabel.fontSize = _magic.get("endgameScoreSize") as CGFloat
        scoreLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 200)
        
        self.addChild(scoreLabel)
    }
    
    
    func addTime() {
        let timeLabel = SKLabelNode(fontNamed: _magic.get("endgameTimeFont") as String)
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
        
        timeLabel.fontSize = _magic.get("endgameTimeSize") as CGFloat
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
        blink()
    }
}
