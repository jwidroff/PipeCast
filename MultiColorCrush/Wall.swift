//
//  Wall.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 9/1/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit

class Wall {
    
    var indexes = Indexes()
//    var shape = String()
    var view = ShapeView()
    var center = CGPoint()
//    var color = UIColor()
    var opacity = Int()
    
    init(){
        
    }
}

class Entrance {
    
    var indexes = Indexes()
    var view = ShapeView()
    var opening = String()
}

class Exit {
    
    var indexes = Indexes()
    var view = ShapeView()
    var opening = String()

}
