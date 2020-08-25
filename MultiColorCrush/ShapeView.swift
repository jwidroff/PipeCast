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
    
//    var name = Int()
//    var view = UIView()
    
    var color: CGColor?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        init(frame: CGRect, color: CGColor) {
            self.color  = color
            super.init(frame: frame)
            self.backgroundColor = UIColor.clear
        }
        
        override func draw(_ rect: CGRect) {
            
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

        }
    
    
    
    
    
}
