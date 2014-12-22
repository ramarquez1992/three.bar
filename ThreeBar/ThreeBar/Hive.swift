//
//  Hive.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/21/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

class Hive: SKSpriteNode {
    override init() {
        let width = _magic.get("hiveSize") as CGFloat
        let height = _magic.get("hiveSize") as CGFloat
        
        let color = UIColor.whiteColor()
        
        super.init(texture: nil, color: color, size: CGSize(width: width, height: height))
        
        //start timer
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}