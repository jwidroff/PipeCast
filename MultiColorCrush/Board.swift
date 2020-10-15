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
    var pieces = [Piece]()
}

class BoardView : UIView {
    
    var context = UIGraphicsGetCurrentContext()
    var xArray = [CGFloat]()
    var yArray = [CGFloat]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, xArray: [CGFloat], yArray: [CGFloat]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.xArray = xArray.sorted(by: { (x1, x2) -> Bool in
            x1 > x2
        })
        self.yArray = yArray.sorted(by: { (y1, y2) -> Bool in
            y1 > y2
        })
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(2.5)
        
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2

        for x in xArray {
                        
            context.beginPath()
            context.move(to: CGPoint(x: x - halfX, y: yArray.first! + halfY))
            context.addLine(to: CGPoint(x: x - halfX, y: yArray.last! - halfY))
            context.strokePath()
        }
        
        for y in yArray {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray.first! + halfX, y: y - halfY))
            context.addLine(to: CGPoint(x: xArray.last! - halfX, y: y - halfY))
            context.strokePath()
        }

        setNeedsDisplay()
        
        self.context = context

    }
}

