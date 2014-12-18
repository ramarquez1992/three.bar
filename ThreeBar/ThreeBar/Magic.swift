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
    var plist: [String:AnyObject]
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource("Magic", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String:AnyObject] {
                
                plist = dict
            
            } else { fatalError("Failed to load \"Magic\" dictionary") }
        } else { fatalError("Failed to load \"Magic.plist\"") }
    }
    
    func get(key: String) -> AnyObject? {
        return plist[key]
    }
}