//
//  ViewController.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/10/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = Model()
    var pieceWidth = CGFloat()
    var pieceHeight = CGFloat()
    var boardWidth = CGFloat()
    var boardHeight = CGFloat()
    var degrees = 90.0
    var piecesWereEnlarged = false
    var distanceFromPieceCenter = CGFloat()
    var ballPath = UIBezierPath()
    var piecesCrossed:Double = 0
    var delayAmount = 0.0
    var deviceIsNarrow = Bool()
    var retryButton = UIButton()
    var menuButton = UIButton()
    var widthCushion = CGFloat()
    var heightCushion = CGFloat()
    var colorTheme = ColorTheme()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = colorTheme.gameBackground
        model = Model()
        model.delegate = self
        model.setUpGame()
        addSwipeGestureRecognizer(view: model.board.view)
    }
    
    func setupGrid() {

        let frameX = (self.model.board.view.frame.width - boardWidth) / 2
        let frameY = (self.model.board.view.frame.height - boardHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
        self.model.board.grid = GridPoints(frame: frame, height: self.model.board.heightSpaces, width: self.model.board.widthSpaces).getGrid()
    }
    
    func setupBalls() {
                
        for ball in self.model.board.balls {
            
            let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
            ball.view = BallView(frame: frame)
            ball.view.center = CGPoint(x: model.board.grid[ball.indexes]?.x ?? ball.view.center.x, y: model.board.grid[ball.indexes]?.y ?? ball.view.center.y)
            addTapGestureRecognizer(view: ball.view)
            self.model.board.view.addSubview(ball.view)
        }
    }
    
    func setupBoard() {
        
        var frameY = CGFloat()
        
        if deviceIsNarrow {
            
            
            frameY = self.view.frame.midY - (boardHeight / 2) - (heightCushion / 4)

            
        } else {
            
            frameY = self.view.frame.midY - (boardHeight / 2)

            
        }
        
        let frameX = self.view.frame.midX - (boardWidth / 2)

//        let frameY = self.view.frame.midY - (boardHeight / 2)
        let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
        var xArray = [CGFloat]()
        var yArray = [CGFloat]()
        
        for point in self.model.board.grid.values {
                        
            if !xArray.contains(point.x) {
                
                xArray.append(point.x)
            }
            
            if !yArray.contains(point.y) {
                
                yArray.append(point.y)
            }
        }
        
        let boardView = BoardView(frame: frame, xArray: xArray, yArray: yArray, iceLocations: model.board.iceLocations, holeLocations: model.board.holeLocations)
        self.model.board.view = boardView
        self.model.board.view.backgroundColor = colorTheme.boardBackground
        view.addSubview(self.model.board.view)
    }
    
    func setSizes() {
        
        widthCushion = (self.view.frame.width / CGFloat(model.board.widthSpaces * 2))
//        let widthCushion:CGFloat = 10.0
        heightCushion = (self.view.frame.height / CGFloat(model.board.heightSpaces))
        
//        let widthCushion:CGFloat = pieceWidth
//        let heightCushion:CGFloat = pieceHeight
        
        if self.view.frame.width < (self.view.frame.height / 2) {
            
            boardHeight = (self.view.frame.width - widthCushion) * 2
            boardWidth = self.view.frame.width - widthCushion
            
            print("Narrow Device")
            deviceIsNarrow = true

        } else if self.view.frame.width > (self.view.frame.height / 2) {
        
            boardWidth = (self.view.frame.height - heightCushion) / 2
            boardHeight = self.view.frame.height - heightCushion
            
            print("Wide Device")
            deviceIsNarrow = false

        }
        
        pieceWidth = boardWidth / CGFloat(model.board.widthSpaces) / 10 * 9
        pieceHeight = boardHeight / CGFloat(model.board.heightSpaces) / 10 * 9
        
        distanceFromPieceCenter = (pieceWidth / 9 * 10) / 2
    }
  
    func addSwipeGestureRecognizer(view: UIView) {
        
        var upSwipe = UISwipeGestureRecognizer()
        var downSwipe = UISwipeGestureRecognizer()
        var rightSwipe = UISwipeGestureRecognizer()
        var leftSwipe = UISwipeGestureRecognizer()
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    func addTapGestureRecognizer(view: UIView) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer) {
        
        let pieceCenter = sender.view?.center
        model.handleTap(center: pieceCenter!)
    }
    
    func checkIfBallCanMove(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = Bool()

        switch direction {
            
        case .up:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .down:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .left:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .right:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) {
                bool = true
            } else {
                bool = false
            }

        default:
            break
        }
        return bool
    }
    
    

    
    func curveAnimation(view: UIView, beginPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint, completion: @escaping (Bool) -> Void) {

        ballPath.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        ballPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = ballPath.cgPath
        animation.repeatCount = 0
        piecesCrossed += 0.25

        animation.duration = piecesCrossed
        view.layer.add(animation, forKey: "animate along path")
        view.center = endPoint
        completion(true)
    }
    
    func enlargePieces() {
        
        guard piecesWereEnlarged == false else { return }

        piecesWereEnlarged = true
        for piece in model.board.pieces.sorted(by: { (piece1, piece2) -> Bool in
            piece1.view.center.y < piece2.view.center.y
        }).filter({ (piece) -> Bool in
            piece.shape != .entrance && piece.shape != .exit && piece.shape != .pieceMaker && piece.shape != .wall
        }) {
                        
            let height = (piece.view.frame.height / 9 * 9.75)
            let width = (piece.view.frame.width / 9 * 9.75)
            let x = piece.view.center.x - (width / 2)
            let y = piece.view.center.y - (height / 2)
            piece.view.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer) {
        
        switch sender.direction {
            
        case .up:
            model.movePiece(direction: sender.direction)
            
        case .down:
            model.movePiece(direction: sender.direction)

        case .right:
            model.movePiece(direction: sender.direction)

        case .left:
            model.movePiece(direction: sender.direction)

        default:
            break
        }
    }
    
    func radians(degrees: Double) ->  CGFloat {
        
        return CGFloat(degrees * .pi / degrees)
    }
    
    
    
    
}

extension ViewController: ModelDelegate {

    
    func resetGame() {
        
        
        print("reset game")
        
        
        
        
        
    }
    
    
    func ballCrashInCross(piece: Piece, ball: Ball) {
        
        let yAxisIsAligned:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) == ball.view.center.y
        
        let xAxisIsAligned:Bool = piece.view.frame.minX + (piece.view.frame.width / 2) == ball.view.center.x
        
        let ballIsLowerTanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) < ball.view.center.y
        
        let ballIsHigherThanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) > ball.view.center.y
        
        let ballIsRightOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) < ball.view.center.x
        
        let ballIsLeftOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) > ball.view.center.x
        
        if xAxisIsAligned && ballIsLowerTanPieceCenter {
            
            //Moves the piece up
            let endPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y - (self.pieceHeight / 4 * 3 / 2))
            
            curveAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
                print()
            }
            
        } else if xAxisIsAligned && ballIsHigherThanPieceCenter {
            
            //Moves the piece down
            let endPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y + (self.pieceHeight / 4 * 3 / 2))
            
            curveAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
                print()
            }
            
        } else if yAxisIsAligned && ballIsRightOfPieceCenter {
            
            //Moves the piece left
            let endPoint = CGPoint(x: ball.view.center.x - (self.pieceWidth / 4 * 3 / 2), y: ball.view.center.y) 
            
            curveAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
                print()
            }
            
        } else if yAxisIsAligned && ballIsLeftOfPieceCenter {
            
            //Moves the ball right
            let endPoint = CGPoint(x: ball.view.center.x + (self.pieceWidth / 4 * 3 / 2), y: ball.view.center.y)
            
            curveAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
                print()
            }
        }
    }
    
    
    func removePiece(piece: Piece) {
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseInOut) {
            piece.view.transform = scale

        } completion: { (true) in
            piece.view.removeFromSuperview()

        }

        
//        UIView.animate(withDuration: 0.5) {
//
//            piece.view.transform = scale
//
//
//
//        } completion: { (true) in
//
//
//            piece.view.removeFromSuperview()
//        }

        
    }
    
    func resetPieceMaker(piece: Piece) {
 
        let frame = piece.view.subviews.first!.frame
        let nextPieceView = ShapeView(frame: frame, piece: piece.nextPiece!)
        piece.view.subviews.first!.removeFromSuperview()
        piece.view.addSubview(nextPieceView)
    }
    

    func addPieceView(piece: Piece) {
        
        piece.view.center = self.model.board.grid[piece.indexes]!
        addTapGestureRecognizer(view: piece.view)
        
        UIView.animate(withDuration: 0.25) {
            let rect = CGRect(x: piece.view.frame.minX, y: piece.view.frame.minY, width: self.pieceWidth, height: self.pieceHeight)
            piece.view.frame = rect
            self.model.board.view.addSubview(piece.view)
        }
    }
    
    
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
                
        print("move ball called")
        
        
        var beginPoint = CGPoint()
        var endPoint = CGPoint()
        var controlPoint = CGPoint()
        self.model.board.view.bringSubviewToFront(ball.view)
        
        switch startSide {
        
        case "center":
            
            print("start side = center")
            
            if endSide == "left" {
                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top"{
                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "bottom" {
                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            }
            
            beginPoint = ball.view.center
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.ballPath = UIBezierPath()
                
                switch endSide {
                
                case "top":
                    self.model.moveBall(ball: ball, startSide: "bottom")
                    
                case "bottom":
                    self.model.moveBall(ball: ball, startSide: "top")
                    
                case "left":
                    self.model.moveBall(ball: ball, startSide: "right")
                    
                case "right":
                    self.model.moveBall(ball: ball, startSide: "left")
                    
                default:
                    break
                }
            }
            
        case "top":
            
            print("start side = top")

            
            if endSide == "left" {
                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "bottom" {
                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "center" {
                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in

                self.delayAmount += 0.25
                
                if piece.shape == .cross {
                    self.model.switch4Tap(piece: piece) { (true) in
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.delayAmount * 1000))
                        let backgroundColor = piece.view.backgroundColor?.cgColor

                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                            
                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor

                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                                
                                piece.view.layer.backgroundColor = backgroundColor
                                piece.view.setNeedsDisplay()
                            }
                        }
                    }
                }
                
                switch endSide {
                
                case "top":
                    self.model.moveBall(ball: ball, startSide: "bottom")
                    
                case "bottom":
                    self.model.moveBall(ball: ball, startSide: "top")
                    
                case "left":
                    self.model.moveBall(ball: ball, startSide: "right")
                    
                case "right":
                    self.model.moveBall(ball: ball, startSide: "left")
                    
                default:
                    break
                }
            }
                        
        case "bottom":
            
            print("start side = bottom")

            
            if endSide == "left" {
                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top" {
                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "center" {
                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.delayAmount += 0.25
                
                if piece.shape == .cross {
                    self.model.switch4Tap(piece: piece) { (true) in
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.delayAmount * 1000))
                        let backgroundColor = piece.view.backgroundColor?.cgColor
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                            
                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor

                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                                
                                piece.view.layer.backgroundColor = backgroundColor
                                piece.view.setNeedsDisplay()
                            }
                        }
                    }
                }
                
                switch endSide {
                
                case "top":
                    self.model.moveBall(ball: ball, startSide: "bottom")
                    
                case "bottom":
                    self.model.moveBall(ball: ball, startSide: "top")
                    
                case "left":
                    self.model.moveBall(ball: ball, startSide: "right")
                    
                case "right":
                    self.model.moveBall(ball: ball, startSide: "left")
                    
                default:
                    break
                }
            }

        case "left":
            
            print("start side = left")

            
            if endSide == "bottom" {
                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "right" {
                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "center" {
                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.delayAmount += 0.25
                
                if piece.shape == .cross {
                    self.model.switch4Tap(piece: piece) { (true) in
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.delayAmount * 1000))
                        let backgroundColor = piece.view.backgroundColor?.cgColor
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor

                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                                
                                piece.view.layer.backgroundColor = backgroundColor
                                piece.view.setNeedsDisplay()
                            }
                        }
                    }
                }
                
                switch endSide {
                
                case "top":
                    self.model.moveBall(ball: ball, startSide: "bottom")
                    
                case "bottom":
                    self.model.moveBall(ball: ball, startSide: "top")
                    
                case "left":
                    self.model.moveBall(ball: ball, startSide: "right")
                    
                case "right":
                    self.model.moveBall(ball: ball, startSide: "left")
                    
                default:
                    break
                }
            }
            
        case "right":
            
            print("start side = right")

            
            if endSide == "bottom" {
                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "left" {
                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "center" {
                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.delayAmount += 0.25
                
                if piece.shape == .cross {
                    self.model.switch4Tap(piece: piece) { (true) in
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.delayAmount * 1000))
                        let backgroundColor = piece.view.backgroundColor?.cgColor
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//                            self.pieceWasTapped(piece: piece)
                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor
//                            piece.view.setNeedsDisplay()

                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                                
                                piece.view.layer.backgroundColor = backgroundColor
                                piece.view.setNeedsDisplay()
                            }
                        }
                    }
                }
                
                switch endSide {
                
                case "top":
                    self.model.moveBall(ball: ball, startSide: "bottom")
                    
                case "bottom":
                    self.model.moveBall(ball: ball, startSide: "top")
                    
                case "left":
                    self.model.moveBall(ball: ball, startSide: "right")
                    
                case "right":
                    self.model.moveBall(ball: ball, startSide: "left")
                    
                default:
                    break
                }
            }
            
        default:
            break
        }
    }
    
    
    func movePieces(piece: Piece, direction: UISwipeGestureRecognizer.Direction) {
                
//        for piece in model.board.pieces {
            
//            UIView.animate(withDuration: 0.25) {
                
                if piece.indexes.x! < 0{
                    
                    UIView.animate(withDuration: 0.25) {
                        piece.view.center = CGPoint(x: piece.view.center.x - (self.distanceFromPieceCenter * 2), y: piece.view.center.y)
                    }
//                    self.removePiece(piece: piece)
                    
                    self.model.deletePiece(piece: piece)
                    
                } else if piece.indexes.x! > self.model.board.widthSpaces - 1 {
                    UIView.animate(withDuration: 0.25) {
                        piece.view.center = CGPoint(x: piece.view.center.x + (self.distanceFromPieceCenter * 2), y: piece.view.center.y)
                    }
//                    self.removePiece(piece: piece)
                    self.model.deletePiece(piece: piece)

                } else if piece.indexes.y! < 0 {

                    UIView.animate(withDuration: 0.25) {
                        piece.view.center = CGPoint(x: piece.view.center.x, y: piece.view.center.y - (self.distanceFromPieceCenter * 2))
                    }
//                    self.removePiece(piece: piece)
                    self.model.deletePiece(piece: piece)

                } else if piece.indexes.y! > self.model.board.heightSpaces - 1 {

                    UIView.animate(withDuration: 0.25) {
                        piece.view.center = CGPoint(x: piece.view.center.x, y: piece.view.center.y + (self.distanceFromPieceCenter * 2))
                    }
//                    self.removePiece(piece: piece)
                    self.model.deletePiece(piece: piece)

                } else {

                    UIView.animate(withDuration: 0.25) {
                        piece.view.center = self.model.board.grid[piece.indexes]!
                        
                        for ball in self.model.board.balls {
                            ball.view.center = self.model.board.grid[ball.indexes]!
                        }
                    }
                }
                
                
                
                
                
//            }
//        }
    }
    
    
    
    func setUpPiecesView() {
        
        for piece in model.board.pieces {
        
            let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
            piece.view = ShapeView(frame: frame, piece: piece)
            piece.view.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.view.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.view.center.y)
            addTapGestureRecognizer(view: piece.view)
            model.board.view.addSubview(piece.view)
//            self.makeViewSoft(view: piece.view)

        }
        setupBalls()
    }
    
    
    func setupControls() {
        
        var retryButtonFrame = CGRect()
        var menuButtonFrame = CGRect()

        if deviceIsNarrow == true {
                        
            let buttonWidth = (boardWidth / 2) - 10
            let buttonHeight = heightCushion / 1.5
            let retryButtonYFloat = model.board.view.frame.maxY + 10
            let retryButtonXFloat = model.board.view.frame.minX + (boardWidth / 2) + 10
            let menuButtonYFloat = model.board.view.frame.maxY + 10
            let menuButtonXFloat = model.board.view.frame.minX
            
            retryButtonFrame = CGRect(x: retryButtonXFloat, y: retryButtonYFloat, width: buttonWidth, height: buttonHeight)
            retryButton = UIButton(frame: retryButtonFrame)
            retryButton.layer.cornerRadius = retryButton.frame.height / 2

            menuButtonFrame = CGRect(x: menuButtonXFloat, y: menuButtonYFloat, width: buttonWidth, height: buttonHeight)
            menuButton = UIButton(frame: menuButtonFrame)
            menuButton.layer.cornerRadius = menuButton.frame.height / 2
            
        } else if deviceIsNarrow == false {
                 
            let buttonWidth = model.board.view.frame.minX / 4 * 3
            let buttonHeight = buttonWidth
            let buttonYFloat = model.board.view.frame.maxY - buttonHeight
            let buttonXFloat = model.board.view.frame.maxX + (model.board.view.frame.minX / 8)
            let menuButtonXFloat = model.board.view.frame.minX - (model.board.view.frame.minX / 8) - buttonWidth
            
            retryButtonFrame = CGRect(x: buttonXFloat, y: buttonYFloat, width: buttonWidth , height: buttonHeight)
            retryButton = UIButton(frame: retryButtonFrame)
            retryButton.layer.cornerRadius = retryButton.frame.width / 2

            menuButtonFrame = CGRect(x: menuButtonXFloat, y: buttonYFloat, width: buttonWidth, height: buttonHeight)
            menuButton = UIButton(frame: menuButtonFrame)
            menuButton.layer.cornerRadius = menuButton.frame.height / 2
        }
        
        retryButton.backgroundColor = colorTheme.gameBackground
        retryButton.setTitle("RETRY", for: .normal)
        retryButton.setTitleColor(.black, for: .normal)
        retryButton.addTarget(self, action: #selector(handleTap4Retry(sender:)), for: .touchUpInside)
        makeViewSoft(view: retryButton)
        view.addSubview(retryButton)

        menuButton.backgroundColor = colorTheme.gameBackground
        menuButton.setTitle("MENU", for: .normal)
        menuButton.setTitleColor(UIColor.black, for: .normal)
        menuButton.addTarget(self, action: #selector(handleTap4Menu(sender:)), for: .touchUpInside)
        makeViewSoft(view: menuButton)
        view.addSubview(menuButton)
    }
    
    
    @objc func handleTap4Retry(sender: UITapGestureRecognizer) {
        
        print("Handling Tap 4 retry")
        
        model.resetGame()
        
    }
    
    @objc func handleTap4Menu(sender: UITapGestureRecognizer) {
        
        print("Handling Tap 4 menu")

        
    }
    
    
    
    func makeViewSoft(view: UIView) {
        
//        view = UIView(frame: frame)
//        view.backgroundColor = .black
        
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false

        let cornerRadius: CGFloat = view.frame.height / 2
        let shadowRadius: CGFloat = 3

        let darkShadow = CALayer()
        darkShadow.frame = view.bounds
        darkShadow.backgroundColor = view.backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor(red: 0.87, green: 0.89, blue: 0.93, alpha: 1.0).cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        view.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = view.bounds
        lightShadow.backgroundColor = view.backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        view.layer.insertSublayer(lightShadow, at: 0)
        
//        view.addSubview(yourView)
        
        
        
        
    }
    
    func setUpGame(board: Board) {
                
        setSizes()

        setupGrid()
        
        setupBoard()
        
        setupControls()
    }
    
    func pieceWasTapped(piece: Piece) {
        
        piece.view.setNeedsDisplay()
    }
}




