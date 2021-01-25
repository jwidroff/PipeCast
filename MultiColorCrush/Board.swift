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
    var holeLocations = [Indexes]()
//    var wallLocations = [Indexes]()
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
    var holeLocations = [Indexes]()
    var colorTheme = ColorTheme()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, xArray: [CGFloat], yArray: [CGFloat], iceLocations: [Indexes], holeLocations: [Indexes]) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        
        
        //TODO: Figure out how to put the shadow on the inside
        
//        self.layer.shadowPath = CGPath(rect: bounds, transform: nil)
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 10, height: 10)
//        self.layer.shadowRadius = 5
//        self.layer.shadowOpacity = 1
        
        
        
        
        
        
        self.xArray = xArray.sorted(by: { (x1, x2) -> Bool in
            x1 < x2
        })
        self.yArray = yArray.sorted(by: { (y1, y2) -> Bool in
            y1 < y2
        })
        
        self.iceLocations = iceLocations
        self.holeLocations = holeLocations
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2
        
        
        for iceLocation in iceLocations {
            
            //THE FOLLOWING IS CODE FOR THE GREDIENT. DO NOT DELETE. USE LATER ON WHEN THIS BECOMES A VIEW ON TOP OF THE BOARDVIEW
            
//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//            // 4
//            let startColor = UIColor.cyan
//            guard let startColorComponents = startColor.cgColor.components else { return }
//
//            let endColor = UIColor.blue
//            guard let endColorComponents = endColor.cgColor.components else { return }
//
//            // 5
//            let colorComponents: [CGFloat]
//                = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
//
//
//            // 6
//            let locations:[CGFloat] = [0.0, 1.0]
//
//            // 7
//            guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }
//
//            let startPoint = CGPoint(x: 0, y: self.bounds.height)
//            let endPoint = CGPoint(x: self.bounds.width,y: self.bounds.height)
//
//
//            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
            
            
           

            
            
        
            let rect = CGRect(x: xArray[iceLocation.x!] - halfX, y: yArray[iceLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)

            context.setFillColor(UIColor.cyan.cgColor)
            context.fill(rect)
            context.addRect(rect)
        }
        
        for holeLocation in holeLocations {
            
            let rect = CGRect(x: xArray[holeLocation.x!] - halfX, y: yArray[holeLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
            context.setFillColor(colorTheme.holeColor.cgColor)
            context.fill(rect)
            context.addRect(rect)
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        context.setStrokeColor(colorTheme.gridLineColor.cgColor)
//        context.setStrokeColor(UIColor.gray.cgColor)

        context.setLineWidth(2.5)
        
        
        
        
        
        
        
       
       
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
        
        context.beginPath()
        context.move(to: CGPoint(x: frame.width, y: 0))
        context.addLine(to: CGPoint(x: frame.width, y: frame.height))
        context.strokePath()
        
        
        for y in yArray {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray.first! + halfX, y: y + halfY))
            context.addLine(to: CGPoint(x: xArray.last! - halfX, y: y + halfY))
            context.strokePath()
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: frame.height))
        context.addLine(to: CGPoint(x: frame.width, y: frame.height))
        context.strokePath()


        setNeedsDisplay()
        self.context = context
    }
}

