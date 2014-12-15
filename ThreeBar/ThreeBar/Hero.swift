//
//  Hero.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: Actor {
    init() {
        super.init(texture: SKTexture(imageNamed: "hero"),
            color: UIColor.yellowColor(),
            size: CGSize(width: 100.0, height: 100.0))
        
        name = "heroNode"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}