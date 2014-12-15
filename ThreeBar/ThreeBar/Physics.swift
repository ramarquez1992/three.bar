//
//  Physics.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Actor     : UInt32 = 0b1
    static let Hero      : UInt32 = 0b10
    static let Mob       : UInt32 = 0b100
    static let Projectile: UInt32 = 0b1000
}