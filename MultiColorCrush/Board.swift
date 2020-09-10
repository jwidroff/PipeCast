//
//  Board.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/18/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit


class Board {
    
    var grid = [Indexes: CGPoint]()
    var view = UIView()
    var walls = [Wall]()
    var entrances = [Entrance]()
    var exits = [Exit]()
    var balls = [Ball]()
}
