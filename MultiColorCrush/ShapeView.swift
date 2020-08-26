
//
//  Shape.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/25/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit



class ShapeView : UIView {
    
    var name = String()
    
    var color: CGColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, color: CGColor, shape: String) {
        self.color  = color
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.name = shape
    }
    
    override func draw(_ rect: CGRect) {
        
        
        switch name {
            
        case "square":
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let width = frame.width / 4 * 2
            let height = frame.height / 4 * 2
            let x =  -(width - frame.width) / 2
            let y =  -(height - frame.height) / 2
            let corner1 = CGPoint(x: rect.minX + (frame.width / 10), y: rect.minY + (frame.width / 10))
            let corner2 = CGPoint(x: rect.minX + (frame.width / 10), y: rect.maxY - (frame.width / 10))
            let corner3 = CGPoint(x: rect.maxX - (frame.width / 10), y: rect.maxY - (frame.width / 10))
            let corner4 = CGPoint(x: rect.maxX - (frame.width / 10), y: rect.minY + (frame.width / 10))
            let holeRect = CGRect(x: x, y: y, width: width, height: height)
            context.beginPath()
            context.move(to: corner1)
            context.addLine(to: corner2)
            context.addLine(to: corner3)
            context.addLine(to: corner4)
            context.closePath()
            context.setFillColor(color!)
            context.fillPath()
            context.clear(holeRect)
            
        case "star":
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let rectSideLength = rect.width
            let rectSidePortion = rectSideLength / 5
            let cushion = rectSideLength / 4
            let corner1 = CGPoint(x: rect.minX, y: rectSidePortion * 2)
            let corner2 = CGPoint(x: rectSidePortion * 1.5, y: (rectSidePortion * 2))
            let corner3 = CGPoint(x: rectSidePortion * 2.5, y: rect.minY)
            let corner4 = CGPoint(x: rect.maxX - (rectSidePortion * 1.5), y: (rectSidePortion * 2))
            let corner5 = CGPoint(x: rect.maxX, y: rectSidePortion * 2)
            let corner6 = CGPoint(x: rect.maxX - cushion, y: rectSidePortion * 3)
            let corner7 = CGPoint(x: rectSidePortion * 4.5, y: rect.maxY)
            let corner8 = CGPoint(x: rectSidePortion * 2.5, y: rect.maxY - cushion)
            let corner9 = CGPoint(x: rectSidePortion * 0.5, y: rect.maxY)
            let corner10 = CGPoint(x: rect.minX + cushion, y: rectSidePortion * 3)
            
            context.beginPath()
            context.move(to: corner1)
            context.addLine(to: corner2)
            context.addLine(to: corner3)
            context.addLine(to: corner4)
            context.addLine(to: corner5)
            context.addLine(to: corner6)
            context.addLine(to: corner7)
            context.addLine(to: corner8)
            context.addLine(to: corner9)
            context.addLine(to: corner10)
            context.closePath()
            context.setFillColor(color!)
            context.fillPath()
            
            
        case "triangle":
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let width = frame.width / 4 * 1
            let height = frame.height / 4 * 1
            let x =  -(width - frame.width) / 2
            let y =  -(height - frame.height) / 1.5
            let corner1 = CGPoint(x: rect.minX, y: rect.maxY)
            let corner2 = CGPoint(x: rect.maxX, y: rect.maxY)
            let corner3 = CGPoint(x: rect.midX, y: rect.minY)
            let holeRect = CGRect(x: x, y: y, width: width, height: height)
            
            context.beginPath()
            context.move(to: corner1)
            context.addLine(to: corner2)
            context.addLine(to: corner3)
            context.closePath()
            context.setFillColor(color!)
            context.fillPath()
            context.clear(holeRect)
            
            
            
        default:
            break
        }
    }
}
