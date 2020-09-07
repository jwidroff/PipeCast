
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
    
    var type = String()
    
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
            
        case "cross":
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let width = frame.width / 4 * 0.75
            let height = frame.height / 4 * 2
            let x =  -(width - frame.width) / 2
            let y =  -(height - frame.height) / 2
            let holeRect = CGRect(x: x, y: y, width: width, height: height)

            let width2 = frame.width / 4 * 2
            let height2 = frame.height / 4 * 0.75
            let x2 =  -(width2 - frame.width) / 2
            let y2 =  -(height2 - frame.height) / 2
            let holeRect2 = CGRect(x: x2, y: y2, width: width2, height: height2)

            let pos1 = CGPoint(x: rect.width / 3 * 2, y: rect.minY)
            let pos2 = CGPoint(x: rect.width / 3 * 1, y: rect.minY)
            let pos3 = CGPoint(x: rect.width / 3 * 1, y: rect.height / 3 * 1)
            let pos4 = CGPoint(x: rect.minX, y: rect.height / 3 * 1)
            let pos5 = CGPoint(x: rect.minX, y: rect.height / 3 * 2)
            let pos6 = CGPoint(x: rect.width / 3 * 1, y: rect.height / 3 * 2)
            let pos7 = CGPoint(x: rect.width / 3 * 1, y: rect.maxY)
            let pos8 = CGPoint(x: rect.width / 3 * 2, y: rect.maxY)
            let pos9 = CGPoint(x: rect.width / 3 * 2, y: rect.height / 3 * 2)
            let pos10 = CGPoint(x: rect.maxX, y: rect.height / 3 * 2)
            let pos11 = CGPoint(x: rect.maxX, y: rect.height / 3 * 1)
            let pos12 = CGPoint(x: rect.width / 3 * 2, y: rect.height / 3 * 1)
            
            context.beginPath()
            context.move(to: pos1)
            context.addLine(to: pos2)
            context.addLine(to: pos3)
            context.addLine(to: pos4)
            context.addLine(to: pos5)
            context.addLine(to: pos6)
            context.addLine(to: pos7)
            context.addLine(to: pos8)
            context.addLine(to: pos9)
            context.addLine(to: pos10)
            context.addLine(to: pos11)
            context.addLine(to: pos12)
            context.closePath()
            context.setFillColor(color!)
            context.fillPath()
            context.clear(holeRect)
            context.clear(holeRect2)
            
        case "octigon":
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let width = frame.width / 4 * 1
            let height = frame.height / 4 * 1
            let x =  -(width - frame.width) / 2
            let y =  -(height - frame.height) / 2
            let holeRect = CGRect(x: x, y: y, width: width, height: height)
            let leftTop = CGPoint(x: rect.width / 3 * 1, y: rect.minY)
            let rightTop = CGPoint(x: rect.width / 3 * 2, y: rect.minY)
            let topLeft =  CGPoint(x: rect.minX, y: rect.height / 3 * 1)
            let bottomLeft =  CGPoint(x: rect.minX, y: rect.height / 3 * 2)
            let topRight =  CGPoint(x: rect.maxX, y: rect.height / 3 * 1)
            let bottomright =  CGPoint(x: rect.maxX, y: rect.height / 3 * 2)
            let leftBottom = CGPoint(x: rect.width / 3 * 1, y: rect.maxY)
            let rightBottom = CGPoint(x: rect.width / 3 * 2, y: rect.maxY)
            
            context.beginPath()
            context.move(to: rightTop)
            context.addLine(to: leftTop)
            context.addLine(to: topLeft)
            context.addLine(to: bottomLeft)
            context.addLine(to: leftBottom)
            context.addLine(to: rightBottom)
            context.addLine(to: bottomright)
            context.addLine(to: topRight)
            context.closePath()
            context.setFillColor(color!)
            context.fillPath()
            context.clear(holeRect)
            
        case "regular":
            
             guard let context = UIGraphicsGetCurrentContext() else { return }
//             let width = frame.width / 4 * 2
//             let height = frame.height / 4 * 2
//             let x =  -(width - frame.width) / 2
//             let y =  -(height - frame.height) / 2
             let corner1 = CGPoint(x: rect.minX + (frame.width / 10), y: rect.minY + (frame.width / 10))
             let corner2 = CGPoint(x: rect.minX + (frame.width / 10), y: rect.maxY - (frame.width / 10))
             let corner3 = CGPoint(x: rect.maxX - (frame.width / 10), y: rect.maxY - (frame.width / 10))
             let corner4 = CGPoint(x: rect.maxX - (frame.width / 10), y: rect.minY + (frame.width / 10))
//             let holeRect = CGRect(x: x, y: y, width: width, height: height)
             context.beginPath()
             context.move(to: corner1)
             context.addLine(to: corner2)
             context.addLine(to: corner3)
             context.addLine(to: corner4)
             context.closePath()
             context.setFillColor(color!)
             context.fillPath()
//             context.clear(holeRect)
            
            
        case "elbow":
            
            
            //TODO: Save this - Toggled between elbows
            
            
//            var types = ["left", "right"]
            
            
            if type == "right"{
                
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10
                
                let eclipseHeight1 = frame.height + diff
                let eclipseWidth1 = frame.width + diff
                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.addEllipse(in: rect1)
                context.setFillColor(UIColor.brown.cgColor)
                context.fillEllipse(in: rect1)
                
                let eclipseHeight2 = frame.height - diff
                let eclipseWidth2 = frame.width - diff
                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.addEllipse(in: rect2)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect2)
                
                type = "left"
                
            } else {
                
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                let diff = frame.height / 10
                
                
                
               let eclipseHeight3 = frame.height + diff
                let eclipseWidth3 = frame.width + diff
                let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
                context.addEllipse(in: rect3)
                context.setFillColor(UIColor.purple.cgColor)
                context.fillEllipse(in: rect3)
                
                let eclipseHeight4 = frame.height - diff
                let eclipseWidth4 = frame.width - diff
                let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
                context.addEllipse(in: rect4)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect4)
                
                
                type = "right"
                
            }
            
            
            
//            let eclipseHeight3 = frame.height
//            let eclipseWidth3 = frame.width
//            let rect3 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
//            context.addEllipse(in: rect3)
//            context.setFillColor(UIColor.brown.cgColor)
//            context.fillEllipse(in: rect3)
            
            
            
            print("elbow")
            
            
            
          case "doubleElbow":
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let diff = frame.height / 10
            
            let eclipseHeight1 = frame.height + diff
            let eclipseWidth1 = frame.width + diff
            let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.red.cgColor)
            context.fillEllipse(in: rect1)

            let eclipseHeight2 = frame.height - diff
            let eclipseWidth2 = frame.width - diff
            let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
            context.addEllipse(in: rect2)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect2)
            
            let eclipseHeight3 = frame.height + diff
            let eclipseWidth3 = frame.width + diff
            let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
            context.addEllipse(in: rect3)
            context.setFillColor(UIColor.purple.cgColor)
            context.fillEllipse(in: rect3)
            
            let eclipseHeight4 = frame.height - diff
            let eclipseWidth4 = frame.width - diff
            let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
            context.addEllipse(in: rect4)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect4)
            
            
        case "sword":
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let diff = frame.height / 10
            
            let width = diff * 2
            let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
            let rect5 = CGRect(x: x, y: 0, width: width, height: frame.height)
            context.setFillColor(UIColor.blue.cgColor)
            context.addRects([rect5])
            context.fill(rect5)
            
            
            let eclipseHeight1 = frame.height + diff
            let eclipseWidth1 = frame.width + diff
            let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.red.cgColor)
            context.fillEllipse(in: rect1)

            let eclipseHeight2 = frame.height - diff
            let eclipseWidth2 = frame.width - diff
            let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
            context.addEllipse(in: rect2)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect2)
            
            let eclipseHeight3 = frame.height + diff
            let eclipseWidth3 = frame.width + diff
            let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
            context.addEllipse(in: rect3)
            context.setFillColor(UIColor.purple.cgColor)
            context.fillEllipse(in: rect3)
            
            let eclipseHeight4 = frame.height - diff
            let eclipseWidth4 = frame.width - diff
            let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
            context.addEllipse(in: rect4)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect4)
            
            
            

            
            print("sword")
            
            
        default:
            break
        }
    }
}
