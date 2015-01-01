//
//  Physics.swift
//  ThreeBar
//
//  Created by Marquez, Richard A on 12/14/14.
//  Copyright (c) 2014 Richard Marquez. All rights reserved.
//

import Foundation
import SpriteKit

enum ZIndex: Int {
    case Bottom = 0
    case Wall
    case Lock
    case Door
    case Hive
    case Actor
    case Unit
    case Mob
    case Projectile
    case Laser
    case Hero
    case Explosion
    case HUD
    case Top
}

struct PhysicsCategory {
    static let None       : UInt32 = 0
    static let All        : UInt32 = UInt32.max
    static let Actor      : UInt32 = 0b1
    static let Hero       : UInt32 = 0b10
    static let Mob        : UInt32 = 0b100
    static let Wall       : UInt32 = 0b1000
    static let Projectile : UInt32 = 0b10000
    static let Laser      : UInt32 = 0b100000
    static let ReturnLaser: UInt32 = 0b1000000
    static let Lock       : UInt32 = 0b10000000
    static let Door       : UInt32 = 0b100000000
}


// Vector math functions
func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) ->CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    // Turn into a unit vector (magnitude 1) that is easy to scale
    func normalized() -> CGPoint {
        return self / length()
    }
}

enum Direction: Int {
    case Up = 0
    case Right
    case Down
    case Left
}

func RADIANS_TO_DEGREES(radians: CGFloat) -> CGFloat {
    return CGFloat((Double(radians) / (2 * M_PI)) * 360)
}

func DEGREES_TO_RADIANS(degrees: CGFloat) -> CGFloat {
    return CGFloat((Double(degrees) / 360) * (2 * M_PI))
}
