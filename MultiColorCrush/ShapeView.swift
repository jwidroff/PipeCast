
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
    
    var name:Shape = .regular
    
    var version = Int()
    
    var color: CGColor?
        
    var switches = Int()
    
    var currentSwitch = Int()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, color: CGColor, shape: Shape, version: Int?) {
        
        
        //PICK UP HERE USING THE PIECES VERSION TO DETERMINE WHICH WAY THE PIECE LAYS
        
        
//        print(version)
        
        
        
        self.color  = color
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.name = shape
        
        switch shape {
        case .elbow:
            switches = 2
            currentSwitch = 1
            self.version = version!
            
        case .doubleElbow:
            switches = 2
            currentSwitch = 1

            
        case .sword:
            switches = 3
            currentSwitch = 1
            
        case .cross:
            switches = 2
            currentSwitch = 1

            
        case .quadBox:
            switches = 2
            currentSwitch = 1
            
        case .diagElbow:
            switches = 2
            currentSwitch = 1
            
        default:
            break
        }
        
        
        
    }
    
    override func draw(_ rect: CGRect) {
        
        
        switch name {
            
        case .regular:
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let w = frame.width / 10 * 9
            let h = frame.height / 10 * 9
            let x = (frame.width - w) / 2
            let y = (frame.height - h) / 2
            let rect1 = CGRect(x: x, y: y, width: w, height: h)
            context.setFillColor(UIColor.black.cgColor)
            context.addRects([rect1])
            context.fill(rect1)
            
        case .elbow:

            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let diff = frame.height / 10
            let posHeight = frame.height + diff
            let posWidth = frame.width + diff
            let negHeight = frame.height - diff
            let negWidth = frame.width - diff
                
            
            
            //UP TO HERE. TRY REFACTORING FURTHER
            
            
            
                switch version {
                
                case 1:
                    
                    if currentSwitch == 1 {
                    
                    let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: posWidth, height: posHeight)
                    context.addEllipse(in: rect1)
                    context.setFillColor(color!)
                    context.fillEllipse(in: rect1)
                    
                    let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: negWidth, height: negHeight)
                    context.addEllipse(in: rect2)
                    context.setFillColor(UIColor.black.cgColor)
                    context.fillEllipse(in: rect2)
                    
                    currentSwitch = 2
                    
                    } else {
                    
                        let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect3)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect3)
                        
                        let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect4)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect4)
                        
                        currentSwitch = 1
                        
                    }
                        
                case 2:
                    
                    
                    
                    if currentSwitch == 1 {

                        let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect5)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect5)
                        
                        let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: negWidth, height: negHeight)
                        context.addEllipse(in: rect6)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect6)
                        
                        
                        currentSwitch = 2
                        
                        
                    } else {
                        
                        let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect1)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect1)
                        
                        let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect2)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect2)
                        
                        currentSwitch = 1
                        
                    }
                    
                     
                case 3:
                    
                    
                    if currentSwitch == 1 {

                        let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect7)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect7)
                        
                        let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: negWidth, height: negHeight)
                        context.addEllipse(in: rect8)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect8)
                        
                        
                        currentSwitch = 2
                        
                        
                    } else {
                        
                        let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect5)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect5)
                        
                        let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: negWidth, height: negHeight)
                        context.addEllipse(in: rect6)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect6)
                        currentSwitch = 1
                        
                    }
                    
                    
                case 4:
                    
                    if currentSwitch == 1 {
                        
                        let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: posWidth, height: posHeight)
                        context.addEllipse(in: rect3)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect3)
                        
                        let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: negWidth, height: negHeight)
                        context.addEllipse(in: rect4)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect4)

                       
                        
                        currentSwitch = 2

                        
                        
                    } else {
                        
                        let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: posWidth, height: posHeight)
                        context.addEllipse(in: rect7)
                        context.setFillColor(color!)
                        context.fillEllipse(in: rect7)
                        
                        let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: negWidth, height: negHeight)
                        context.addEllipse(in: rect8)
                        context.setFillColor(UIColor.black.cgColor)
                        context.fillEllipse(in: rect8)
                        
                        currentSwitch = 1
                        
                    }
                    
                default:
                    break
                
                }
                
            
        case .doubleElbow:
            
            
            if currentSwitch == 1 {
                
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
                currentSwitch = 2
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
                
                
                currentSwitch = 1
            }
            
        case .quadBox:
              
              
              if currentSwitch == 1 {
                  
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
                
                
                
                let eclipseHeight5 = frame.height + diff
                let eclipseWidth5 = frame.width + diff
                let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: eclipseWidth5, height: eclipseHeight5)
                context.addEllipse(in: rect5)
                context.setFillColor(UIColor.green.cgColor)
                context.fillEllipse(in: rect5)
                
                let eclipseHeight6 = frame.height - diff
                let eclipseWidth6 = frame.width - diff
                let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: eclipseWidth6, height: eclipseHeight6)
                context.addEllipse(in: rect6)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect6)
                
                
                
                
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
                
                
                
                
                let eclipseHeight7 = frame.height + diff
                let eclipseWidth7 = frame.width + diff
                let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: eclipseWidth7, height: eclipseHeight7)
                context.addEllipse(in: rect7)
                context.setFillColor(UIColor.blue.cgColor)
                context.fillEllipse(in: rect7)
                
                let eclipseHeight8 = frame.height - diff
                let eclipseWidth8 = frame.width - diff
                let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: eclipseWidth8, height: eclipseHeight8)
                context.addEllipse(in: rect8)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect8)
                
                
                
                  currentSwitch = 2
              } else if currentSwitch == 2 {
                  
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
                  
                  
                  
                  
                  let eclipseHeight7 = frame.height + diff
                  let eclipseWidth7 = frame.width + diff
                  let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: eclipseWidth7, height: eclipseHeight7)
                  context.addEllipse(in: rect7)
                  context.setFillColor(UIColor.blue.cgColor)
                  context.fillEllipse(in: rect7)
                  
                  let eclipseHeight8 = frame.height - diff
                  let eclipseWidth8 = frame.width - diff
                  let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: eclipseWidth8, height: eclipseHeight8)
                  context.addEllipse(in: rect8)
                  context.setFillColor(UIColor.black.cgColor)
                  context.fillEllipse(in: rect8)
                  
                  
                
                
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
                
                
                
                let eclipseHeight5 = frame.height + diff
                let eclipseWidth5 = frame.width + diff
                let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: eclipseWidth5, height: eclipseHeight5)
                context.addEllipse(in: rect5)
                context.setFillColor(UIColor.green.cgColor)
                context.fillEllipse(in: rect5)
                
                let eclipseHeight6 = frame.height - diff
                let eclipseWidth6 = frame.width - diff
                let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: eclipseWidth6, height: eclipseHeight6)
                context.addEllipse(in: rect6)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect6)
                
                
                
                  currentSwitch = 1
               }
            
            
            case .diagElbow:
              
              
              if currentSwitch == 1 {
                  
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
                
                
                
                let eclipseHeight5 = frame.height + diff
                let eclipseWidth5 = frame.width + diff
                let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: eclipseWidth5, height: eclipseHeight5)
                context.addEllipse(in: rect5)
                context.setFillColor(UIColor.green.cgColor)
                context.fillEllipse(in: rect5)

                let eclipseHeight6 = frame.height - diff
                let eclipseWidth6 = frame.width - diff
                let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: eclipseWidth6, height: eclipseHeight6)
                context.addEllipse(in: rect6)
                context.setFillColor(UIColor.black.cgColor)
                context.fillEllipse(in: rect6)
                
                  currentSwitch = 2
              } else if currentSwitch == 2 {
                  
                  guard let context = UIGraphicsGetCurrentContext() else { return }
                  
                  let diff = frame.height / 10
                  
                  let eclipseHeight1 = frame.height + diff
                  let eclipseWidth1 = frame.width + diff
                  let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
                  context.addEllipse(in: rect1)
                  context.setFillColor(UIColor.green.cgColor)
                  context.fillEllipse(in: rect1)

                  let eclipseHeight2 = frame.height - diff
                  let eclipseWidth2 = frame.width - diff
                  let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
                  context.addEllipse(in: rect2)
                  context.setFillColor(UIColor.black.cgColor)
                  context.fillEllipse(in: rect2)
                  
                  
                  
                  
                  let eclipseHeight7 = frame.height + diff
                  let eclipseWidth7 = frame.width + diff
                  let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: eclipseWidth7, height: eclipseHeight7)
                  context.addEllipse(in: rect7)
                  context.setFillColor(UIColor.purple.cgColor)
                  context.fillEllipse(in: rect7)
                  
                  let eclipseHeight8 = frame.height - diff
                  let eclipseWidth8 = frame.width - diff
                  let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: eclipseWidth8, height: eclipseHeight8)
                  context.addEllipse(in: rect8)
                  context.setFillColor(UIColor.black.cgColor)
                  context.fillEllipse(in: rect8)
       
                
                
                  currentSwitch = 1
               }
            
            
            
//        case .regular:
//
//
//            if currentSwitch == 1 {
//
//              guard let context = UIGraphicsGetCurrentContext() else { return }
//
//              let diff = frame.height / 10
//
//
//              let eclipseHeight3 = frame.height + diff
//              let eclipseWidth3 = frame.width + diff
//              let rect3 = CGRect(x: (frame.width / 2) - (diff), y: (-frame.height / 2), width: eclipseWidth3, height: eclipseHeight3)
//              context.addEllipse(in: rect3)
//              context.setFillColor(UIColor.purple.cgColor)
//              context.fillEllipse(in: rect3)
//
//              let eclipseHeight4 = frame.height - diff
//              let eclipseWidth4 = frame.width - diff
//              let rect4 = CGRect(x: (frame.width / 2) + (diff), y: (-frame.height / 2), width: eclipseWidth4, height: eclipseHeight4)
//              context.addEllipse(in: rect4)
//              context.setFillColor(UIColor.black.cgColor)
//              context.fillEllipse(in: rect4)
//
//
//              let eclipseHeight5 = frame.height + diff
//              let eclipseWidth5 = frame.width + diff
//              let rect5 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) - diff, width: eclipseWidth5, height: eclipseHeight5)
//              context.addEllipse(in: rect5)
//              context.setFillColor(UIColor.blue.cgColor)
//              context.fillEllipse(in: rect5)
//
//              let eclipseHeight6 = frame.height - diff
//              let eclipseWidth6 = frame.width - diff
//              let rect6 = CGRect(x: (-frame.width / 2), y: (frame.height / 2) + diff , width: eclipseWidth6, height: eclipseHeight6)
//              context.addEllipse(in: rect6)
//              context.setFillColor(UIColor.black.cgColor)
//              context.fillEllipse(in: rect6)
//
//
//                currentSwitch = 2
//            } else if currentSwitch == 2 {
//
//                guard let context = UIGraphicsGetCurrentContext() else { return }
//
//                let diff = frame.height / 10
//
//
//                let eclipseHeight1 = frame.height + diff
//                let eclipseWidth1 = frame.width + diff
//                let rect1 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth1, height: eclipseHeight1)
//                context.addEllipse(in: rect1)
//                context.setFillColor(UIColor.blue.cgColor)
//                context.fillEllipse(in: rect1)
//
//                let eclipseHeight2 = frame.height - diff
//                let eclipseWidth2 = frame.width - diff
//                let rect2 = CGRect(x: (-frame.width / 2), y: (-frame.height / 2), width: eclipseWidth2, height: eclipseHeight2)
//                context.addEllipse(in: rect2)
//                context.setFillColor(UIColor.black.cgColor)
//                context.fillEllipse(in: rect2)
//
//
//
//
//                let eclipseHeight7 = frame.height + diff
//                let eclipseWidth7 = frame.width + diff
//                let rect7 = CGRect(x: (frame.width / 2) - (diff), y: (frame.height / 2) - diff, width: eclipseWidth7, height: eclipseHeight7)
//                context.addEllipse(in: rect7)
//                context.setFillColor(UIColor.purple.cgColor)
//                context.fillEllipse(in: rect7)
//
//                let eclipseHeight8 = frame.height - diff
//                let eclipseWidth8 = frame.width - diff
//                let rect8 = CGRect(x: (frame.width / 2) + (diff), y: (frame.height / 2) + diff, width: eclipseWidth8, height: eclipseHeight8)
//                context.addEllipse(in: rect8)
//                context.setFillColor(UIColor.black.cgColor)
//                context.fillEllipse(in: rect8)
//
//
//
//                currentSwitch = 1
//             }
            
        case .sword:
            
            switch currentSwitch {
            case 1:
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
                
                let width = diff * 2
                let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
                let rect5 = CGRect(x: x, y: 0, width: width, height: frame.height)
                context.setFillColor(UIColor.blue.cgColor)
                context.addRects([rect5])
                context.fill(rect5)
                
                
                currentSwitch += 1
            case 2:
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
                
                currentSwitch += 1

                
            case 3:
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
                
                currentSwitch = 1
                
                
            default:
                break
            }
            
        case .cross:

                switch currentSwitch {
                case 1:
                    
                    
                    guard let context = UIGraphicsGetCurrentContext() else { return }
                    
                    let diff = frame.height / 10
                    let width = diff * 2
                    let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
                    let rect1 = CGRect(x: x, y: 0, width: width, height: frame.height)
                    context.setFillColor(UIColor.blue.cgColor)
                    context.addRects([rect1])
                    context.fill(rect1)
                    
                    let rect2 = CGRect(x: 0, y: x, width: frame.height, height: width)
                    context.setFillColor(UIColor.green.cgColor)
                    context.addRects([rect2])
                    context.fill(rect2)
                    currentSwitch = 2
                case 2:
                    
                    guard let context = UIGraphicsGetCurrentContext() else { return }

                    
                    let diff = frame.height / 10
                    let width = diff * 2
                    let x = ((frame.width / 2) - (diff / 2)) - (width / 4)
                    
                    let rect2 = CGRect(x: 0, y: x, width: frame.height, height: width)
                    context.setFillColor(UIColor.green.cgColor)
                    context.addRects([rect2])
                    context.fill(rect2)
                    
                    let rect1 = CGRect(x: x, y: 0, width: width, height: frame.height)
                    context.setFillColor(UIColor.blue.cgColor)
                    context.addRects([rect1])
                    context.fill(rect1)
                    
                    currentSwitch = 1
                    
                default:
                    break
                }
                
                
        case .ball:
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let eclipseHeight1 = frame.height / 5
            let eclipseWidth1 = frame.width / 5
            let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.systemPink.cgColor)
            context.fillEllipse(in: rect1)

        default:
            break
        }
    }
}



enum Shape {
    
    case elbow
    case doubleElbow
    case diagElbow
    case sword
    case cross
    case quadBox
    case regular
    case ball
}





