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
    var iceLocations = [Indexes]()
    var fireLocations = [Indexes]()
    var randomPieceColors = [UIColor]()
    var randomPieceShapes = [Shape]()
    var amountOfRandomPieces = Int()
    var balls = [Ball]()
    var pieces = [Piece]()
    var heightSpaces = Int()
    var widthSpaces = Int()
}

class BoardView : UIView {
    
    var context = UIGraphicsGetCurrentContext()
    var xArray = [CGFloat]()
    var yArray = [CGFloat]()
    var iceLocations = [Indexes]()
    var fireLocations = [Indexes]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, xArray: [CGFloat], yArray: [CGFloat], iceLocations: [Indexes], fireLocations: [Indexes]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
//        let gradient = CAGradientLayer()
//        gradient.startPoint = .init(x: 0.0, y: -0.1)
//        gradient.endPoint = .init(x: 0.0, y: 1.0)
//        gradient.locations = [0.0, 0.7]
//        gradient.frame = bounds
//        gradient.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor]
//        layer.insertSublayer(gradient, at: 0)
        
        self.xArray = xArray.sorted(by: { (x1, x2) -> Bool in
            x1 < x2
        })
        self.yArray = yArray.sorted(by: { (y1, y2) -> Bool in
            y1 < y2
        })
        
        self.iceLocations = iceLocations
        self.fireLocations = fireLocations

    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setLineWidth(2.5)
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2

        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: frame.maxY))
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: frame.maxX, y: 0))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.strokePath()
        
        for x in xArray {
                        
            context.beginPath()
            context.move(to: CGPoint(x: x + halfX, y: yArray.first! + halfY))
            context.addLine(to: CGPoint(x: x + halfX, y: yArray.last! - halfY))
            context.strokePath()
        }
        
        for y in yArray {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray.first! + halfX, y: y + halfY))
            context.addLine(to: CGPoint(x: xArray.last! - halfX, y: y + halfY))
            context.strokePath()
        }
        
        for iceLocation in iceLocations {
            
            let rect = CGRect(x: xArray[iceLocation.x!] - halfX, y: yArray[iceLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
            context.setFillColor(UIColor.cyan.cgColor)
            context.fill(rect)
            context.addRect(rect)
        }
        
        for fireLocation in fireLocations {
            
            let rect = CGRect(x: xArray[fireLocation.x!] - halfX, y: yArray[fireLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
            context.setFillColor(UIColor.systemPink.cgColor)
            context.fill(rect)
            context.addRect(rect)
        }

        setNeedsDisplay()
        self.context = context
    }
}

