//
//  Magic.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/16/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

let _magic = Magic()

class Magic {
    let heroSize = CGFloat()
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource("Magic", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String:AnyObject] {
                heroSize = CGFloat(dict["heroSize"] as Int)
            }
        }
    }
}