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
        context.setStrokeColor(UIColor.cyan.cgColor)
        context.setLineWidth(1.5)
        
        let xHalfDistance = sqrt((xArray[0] - xArray[1]) * (xArray[0] - xArray[1])) / 2
        let yHalfDistance = sqrt((yArray[0] - yArray[1]) * (yArray[0] - yArray[1])) / 2

        for index in 0..<xArray.count {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray[index] + xHalfDistance, y: yArray.first! - yHalfDistance))
            context.addLine(to: CGPoint(x: xArray[index] + xHalfDistance, y: yArray.last! + yHalfDistance))
            context.strokePath()
        }
        
        for index in 0..<yArray.count {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray.first! - xHalfDistance, y: yArray[index] + yHalfDistance))
            context.addLine(to: CGPoint(x: xArray.last! + xHalfDistance, y: yArray[index] + yHalfDistance))
            context.strokePath()
        }
        
//        context.beginPath()
//        context.move(to: CGPoint(x: xArray[1], y: yArray.first!))
//        context.addLine(to: CGPoint(x: xArray[1], y: yArray.last!))
//        context.strokePath()
        setNeedsDisplay()
        
        self.context = context
        

        
    }
}

