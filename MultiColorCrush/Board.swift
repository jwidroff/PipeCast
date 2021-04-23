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
        
        
        
        addIce(iceLocations: self.iceLocations)
        
        addHoles(holeLocations: self.holeLocations)

        
        
        
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2
        
        
        //THE FOLLOWING IS CODE FOR THE GREDIENT. DO NOT DELETE. USE LATER ON WHEN THIS BECOMES A VIEW ON TOP OF THE BOARDVIEW

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        // 4
        let startColor = UIColor.purple
        guard let startColorComponents = startColor.cgColor.components else { return }

        let endColor = UIColor.brown
        guard let endColorComponents = endColor.cgColor.components else { return }

        // 5
        let colorComponents: [CGFloat]
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]


        // 6
        let locations:[CGFloat] = [0.0, 1.0]

        // 7
        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }

        let startPoint = CGPoint(x: 0, y: self.bounds.height)
        let endPoint = CGPoint(x: self.bounds.width,y: self.bounds.height)

        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(1)))

        
        
        
        

        
//        for holeLocation in holeLocations {
//
//            let rect = CGRect(x: xArray[holeLocation.x!] - halfX, y: yArray[holeLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
//            context.setFillColor(colorTheme.holeColor.cgColor)
//            context.fill(rect)
//            context.addRect(rect)
//        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
    
    private func addIce(iceLocations: [Indexes]) {
        
        
        for iceLocation in self.iceLocations {
            
            //THE FOLLOWING IS CODE FOR THE GREDIENT. DO NOT DELETE. USE LATER ON WHEN THIS BECOMES A VIEW ON TOP OF THE BOARDVIEW

//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//            // 4
//            let startColor = UIColor.purple
//            guard let startColorComponents = startColor.cgColor.components else { return }
//
//            let endColor = UIColor.brown
//            guard let endColorComponents = endColor.cgColor.components else { return }
//
//            // 5
////            let colorComponents: [CGFloat]
////                = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
//
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
//            let yLoc = CGFloat(yArray[iceLocation.y!])
//            let xLoc = CGFloat(xArray[iceLocation.x!])
//
//            let yloc2 = CGFloat(yArray[iceLocation.y! + 1])
//            let xloc2 = CGFloat(xArray[iceLocation.x! + 1])
//
//            let startPoint = CGPoint(x: xLoc, y: yLoc)
//            let endPoint = CGPoint(x: xloc2,y: yloc2)
//
////
////            let startPoint = CGPoint(x: 0, y: self.bounds.height)
////            let endPoint = CGPoint(x: self.bounds.width,y: self.bounds.height)
//
//            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
//
//
//
//
//
////            let rect = CGRect(x: xArray[iceLocation.x!] - halfX, y: yArray[iceLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
////
////            let iceView = IceView(frame: rect)
////            addSubview(iceView)
            
          
            
            
            
            //TODO: Just added Ice class - need to put gradient from above on just the ice
            

            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2
            
            
//            for iceLocation in iceLocations {
                
                
            let rect = CGRect(x: self.xArray[iceLocation.x!] - halfX, y: self.yArray[iceLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)

              

            let iceView = IceView(frame: rect, iceLocation: iceLocation)
            addSubview(iceView)
            
//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//            let cfArray = CFArray(.blue)
//            let gradient = CGGradient(colorsSpace: colorSpace, colors: , locations: <#T##UnsafePointer<CGFloat>?#>)
                
//            }
        
            

//            context.setFillColor(UIColor.cyan.cgColor)
//            context.fill(rect)
//            context.addRect(rect)
            
        }
        
        
        
        
        
    }
    
    private func addHoles(holeLocations: [Indexes]) {
        
        
        for holeLocation in self.holeLocations {
            
            //THE FOLLOWING IS CODE FOR THE GREDIENT. DO NOT DELETE. USE LATER ON WHEN THIS BECOMES A VIEW ON TOP OF THE BOARDVIEW

//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//            // 4
//            let startColor = UIColor.purple
//            guard let startColorComponents = startColor.cgColor.components else { return }
//
//            let endColor = UIColor.brown
//            guard let endColorComponents = endColor.cgColor.components else { return }
//
//            // 5
////            let colorComponents: [CGFloat]
////                = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
//
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
//            let yLoc = CGFloat(yArray[iceLocation.y!])
//            let xLoc = CGFloat(xArray[iceLocation.x!])
//
//            let yloc2 = CGFloat(yArray[iceLocation.y! + 1])
//            let xloc2 = CGFloat(xArray[iceLocation.x! + 1])
//
//            let startPoint = CGPoint(x: xLoc, y: yLoc)
//            let endPoint = CGPoint(x: xloc2,y: yloc2)
//
////
////            let startPoint = CGPoint(x: 0, y: self.bounds.height)
////            let endPoint = CGPoint(x: self.bounds.width,y: self.bounds.height)
//
//            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
//
//
//
//
//
////            let rect = CGRect(x: xArray[iceLocation.x!] - halfX, y: yArray[iceLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
////
////            let iceView = IceView(frame: rect)
////            addSubview(iceView)
            
          
            
            
            
            //TODO: Just added Ice class - need to put gradient from above on just the ice
            

            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2
            
            
//            for iceLocation in iceLocations {
                
                
            let rect = CGRect(x: self.xArray[holeLocation.x!] - halfX, y: self.yArray[holeLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)

              

            let holeView = HoleView(frame: rect, holeLocation: holeLocation)
            addSubview(holeView)
            
//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//            let cfArray = CFArray(.blue)
//            let gradient = CGGradient(colorsSpace: colorSpace, colors: , locations: <#T##UnsafePointer<CGFloat>?#>)
                
//            }
        
            

//            context.setFillColor(UIColor.cyan.cgColor)
//            context.fill(rect)
//            context.addRect(rect)
            
        }
        
        
        
        
        
    }
    
    
    
    
}


class IceView: UIView {
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        self.frame = frame
        
    }
    
    init(frame: CGRect, iceLocation: Indexes) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
        
        
        
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//        // 4
//        let startColor = UIColor.green
//        guard let startColorComponents = startColor.cgColor.components else { return }
//
//        let endColor = UIColor.brown
//        guard let endColorComponents = endColor.cgColor.components else { return }
//
//        // 5
//        let colorComponents: [CGFloat]
//            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
//
//
//        // 6
//        let locations:[CGFloat] = [0.0, 1.0]
//
//        // 7
//        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }
//
//
//
//
//        let startPoint = CGPoint(x: self.frame.minX, y: self.frame.minY)
//        let endPoint = CGPoint(x: self.frame.maxX,y: self.frame.maxY)
//
////        let yLoc = CGFloat(yArray[iceLocation.y!])
////        let xLoc = CGFloat(yArray[iceLocation.x!])
////
////        let yloc2 = CGFloat(yArray[iceLocation.y! + 1])
////        let xloc2 = CGFloat(yArray[iceLocation.x! + 1])
////
////        let startPoint = CGPoint(x: xLoc, y: yLoc)
////        let endPoint = CGPoint(x: xLoc,y: yLoc)
//
//
//
//        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        
//        context.drawRadialGradient(gradient, startCenter: startPoint, startRadius: 100.5, endCenter: endPoint, endRadius: 100.5, options: .drawsBeforeStartLocation)
        
        
        
        let gradient = CAGradientLayer()
        
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient.startPoint = .init(x: 0.0, y: 0.0)
        gradient.endPoint = .init(x: 0.0, y: 2.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient.locations = [-0.1, 0.5, 1.1]
        
        //This keeps the gradient within the bounds of the view
        gradient.frame = bounds
        gradient.opacity = 0.5
        //These are the colors of the gradient(that are being passed in)
        gradient.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor, UIColor.cyan.cgColor]
        

        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient, at: 1)
        
        
        let gradient2 = CAGradientLayer()
        
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient2.startPoint = .init(x: 0.0, y: 0.0)
        gradient2.endPoint = .init(x: 2.0, y: 0.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient2.locations = [-0.1, 0.5, 1.1]
        
        //This keeps the gradient within the bounds of the view
        gradient2.frame = bounds
        gradient2.opacity = 0.5
        //These are the colors of the gradient(that are being passed in)
        gradient2.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor, UIColor.cyan.cgColor]
        

        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient2, at: 2)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    
    
    
    
}


class HoleView: UIView {
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
        
    }
    
    init(frame: CGRect, holeLocation: Indexes) {
        
        super.init(frame: frame)
        self.backgroundColor = ColorTheme().gameBackground
        self.frame = frame
        
        
        
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//        // 4
//        let startColor = UIColor.green
//        guard let startColorComponents = startColor.cgColor.components else { return }
//
//        let endColor = UIColor.brown
//        guard let endColorComponents = endColor.cgColor.components else { return }
//
//        // 5
//        let colorComponents: [CGFloat]
//            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
//
//
//        // 6
//        let locations:[CGFloat] = [0.0, 1.0]
//
//        // 7
//        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }
//
//
//
//
//        let startPoint = CGPoint(x: self.frame.minX, y: self.frame.minY)
//        let endPoint = CGPoint(x: self.frame.maxX,y: self.frame.maxY)
//
////        let yLoc = CGFloat(yArray[iceLocation.y!])
////        let xLoc = CGFloat(yArray[iceLocation.x!])
////
////        let yloc2 = CGFloat(yArray[iceLocation.y! + 1])
////        let xloc2 = CGFloat(yArray[iceLocation.x! + 1])
////
////        let startPoint = CGPoint(x: xLoc, y: yLoc)
////        let endPoint = CGPoint(x: xLoc,y: yLoc)
//
//
//
//        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        
//        context.drawRadialGradient(gradient, startCenter: startPoint, startRadius: 100.5, endCenter: endPoint, endRadius: 100.5, options: .drawsBeforeStartLocation)
        
        
        
        let gradient = CAGradientLayer()
        
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient.startPoint = .init(x: 0.0, y: 0.0)
        gradient.endPoint = .init(x: 0.0, y: 1.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient.locations = [0.1, 0.5, 0.9]
        
        //This keeps the gradient within the bounds of the view
        gradient.frame = bounds
        gradient.opacity = 1.0
        //These are the colors of the gradient(that are being passed in)
        gradient.colors = [ColorTheme().gameBackground.cgColor]
        

        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient, at: 1)
        
        
        let gradient2 = CAGradientLayer()
        
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient2.startPoint = .init(x: 0.0, y: 0.0)
        gradient2.endPoint = .init(x: 1.0, y: 0.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient2.locations = [0.1, 0.5, 0.9]
        
        //This keeps the gradient within the bounds of the view
        gradient2.frame = bounds
        gradient2.opacity = 1.0
        //These are the colors of the gradient(that are being passed in)
        gradient2.colors = [ColorTheme().gameBackground.cgColor]
        

        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient2, at: 2)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    
    
    
    
}
