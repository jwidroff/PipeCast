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
//    var degrees = 90.0
    var piecesWereEnlarged = false
    var distanceFromPieceCenter = CGFloat()
    var ballPath = UIBezierPath()
//    var piecesCrossed:Double = 0
    var deviceIsNarrow = Bool()
    var retryButton = UIButton()
    var menuButton = UIButton()
    var widthCushion = CGFloat()
    var heightCushion = CGFloat()
    var colorTheme = ColorTheme()
    var boardView = UIView()
    var ballEndingPoint = CGPoint()
    var duration4Animation = 0.25
//    let delayedTime = DispatchTime.now() + .milliseconds(Int(500))
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = colorTheme.gameBackground
        model = Model()
        model.delegate = self
        model.setUpGame()
    }
    
    //MARK: Initial Setup
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
        
        boardView = BoardView(frame: frame, xArray: xArray, yArray: yArray, iceLocations: model.board.iceLocations, holeLocations: model.board.holeLocations)
        self.model.board.view = boardView
        self.model.board.view.backgroundColor = colorTheme.boardBackground
        self.addSwipeGestureRecognizer(view: model.board.view)
        view.addSubview(self.model.board.view)
    }
    
    func setSizes() {
        
        widthCushion = (self.view.frame.width / CGFloat(model.board.widthSpaces * 2))
        heightCushion = (self.view.frame.height / CGFloat(model.board.heightSpaces))
        print("width = \(self.view.frame.width - widthCushion)")
        print("height = \(self.view.frame.height)")
        
        //Iphone8 plus
        //W = 414.0
        //H = 736
        
        //TODO: Make it that this changes the calculation if the widthCusion is too small (iPhone 7, 8)
        
        if self.view.frame.width > (self.view.frame.height / 2) {
            
            boardWidth = (self.view.frame.height - heightCushion) / 2
            boardHeight = (self.view.frame.height - heightCushion)
            
            print("Wide Device")
            deviceIsNarrow = false

        } else if self.view.frame.width < (self.view.frame.height / 2) {
        
            boardHeight = (self.view.frame.width - widthCushion) * 2
            boardWidth = self.view.frame.width - widthCushion
            
            print("Narrow Device")
            deviceIsNarrow = true
        }
        
        pieceWidth = boardWidth / CGFloat(model.board.widthSpaces) / 10 * 9.5
        pieceHeight = boardHeight / CGFloat(model.board.heightSpaces) / 10 * 9.5
        distanceFromPieceCenter = (pieceWidth / 9 * 10) / 2
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
        
        retryButton.backgroundColor = colorTheme.buttonColors
        retryButton.setTitle("RETRY", for: .normal)
        retryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retryButton.setTitleColor(colorTheme.buttonTextColor, for: .normal)
        retryButton.addTarget(self, action: #selector(handleTap4Retry(sender:)), for: .touchUpInside)
        
        retryButton.showsTouchWhenHighlighted = true
//        makeViewSoft(view: retryButton)
        view.addSubview(retryButton)

        menuButton.backgroundColor = colorTheme.buttonColors
        menuButton.setTitle("MENU", for: .normal)
        menuButton.titleLabel?.adjustsFontSizeToFitWidth = true
        menuButton.setTitleColor(colorTheme.buttonTextColor, for: .normal)
        menuButton.addTarget(self, action: #selector(handleTap4Menu(sender:)), for: .touchUpInside)
        menuButton.showsTouchWhenHighlighted = true
//        makeViewSoft(view: menuButton)
        view.addSubview(menuButton)
    }
    
    func makeViewSoft(view: UIView) {
        
        //TODO: This needs to be adjusted.
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false

        let cornerRadius: CGFloat = view.frame.height / 2
        let shadowRadius: CGFloat = 3

        let darkShadow = CALayer()
        darkShadow.frame = view.bounds
        darkShadow.backgroundColor = view.backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        view.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = view.bounds
        lightShadow.backgroundColor = view.backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.black.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        view.layer.insertSublayer(lightShadow, at: 0)
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
    
    //MARK: Handle Functions
    
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
    
    @objc func handleTap(sender:UITapGestureRecognizer) {
        
        let pieceCenter = sender.view?.center
        model.handleTap(center: pieceCenter!)
    }
    
    @objc func handleTap4Retry(sender: UITapGestureRecognizer) {
                        
        print("Handling Tap 4 retry")
        runPopUpView(title: "", message: "Are you sure you want to restart?")
    }
    
    @objc func handleTap4Menu(sender: UITapGestureRecognizer) {
        
        print("Handling Tap 4 menu")
        runMenuView()
    }
    
    func runMenuView() {
        
        //TODO: Finish this
        let width = self.view.frame.width / 10 * 9
        let height = self.view.frame.height / 10 * 9
        let x = (self.view.frame.width - width) / 2
        let y = (self.view.frame.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let menuView = MenuView(frame: frame)
        view.addSubview(menuView)
    }

    func radians(degrees: Double) ->  CGFloat {
        
        return CGFloat(degrees * .pi / degrees)
    }
    
    //MARK: Ball functions
    
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
    
    func calculateAnimation(view: UIView, beginPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint, completion: @escaping (Bool) -> Void) {

        ballPath.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        ballPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        ballEndingPoint = endPoint
        completion(true)
    }
    
    func changePieceAfterBallMoves(piece: Piece, ball: Ball) {
        
        let pieceX = self.model.getPieceInfo(index: ball.indexes)
        
        pieceX.isLocked = true
        
        let view = ShapeView(frame: pieceX.view.frame, piece: pieceX)
        
        piece.view.removeFromSuperview()
        
        piece.view = view
        
        self.model.board.view.addSubview(piece.view)
        
        piece.view.setNeedsDisplay()
        
        self.model.board.view.bringSubviewToFront(ball.view)
        
    }
    
    func animateMove(ball: Ball, endSide: String) {
        
        let pieceX = self.model.getPieceInfo(index: ball.indexes)
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            
            self.ballPath = UIBezierPath()
            
            switch endSide {

            case "top":
                
                CATransaction.begin()
                CATransaction.setCompletionBlock {
                    
                    if pieceX.shape == .cross && pieceX.side.top.closing.isOpen != false {
                        
                        self.model.switchCross(piece: pieceX, ball: ball)
                        self.model.board.view.bringSubviewToFront(ball.view)
                    }
                }
                self.model.moveBall(ball: ball, startSide: "bottom")
                CATransaction.commit()
                
            case "bottom":
                
                CATransaction.begin()
                CATransaction.setCompletionBlock {
                    
                    if pieceX.shape == .cross && pieceX.side.bottom.closing.isOpen != false{
                        
                        self.model.switchCross(piece: pieceX, ball: ball)
                        self.model.board.view.bringSubviewToFront(ball.view)
                    }
                }
                self.model.moveBall(ball: ball, startSide: "top")
                CATransaction.commit()
                
            case "left":
                
                CATransaction.begin()
                CATransaction.setCompletionBlock {
                    
                    if pieceX.shape == .cross && pieceX.side.left.closing.isOpen != false {
                        
                        self.model.switchCross(piece: pieceX, ball: ball)
                        self.model.board.view.bringSubviewToFront(ball.view)
                    }
                }
                self.model.moveBall(ball: ball, startSide: "right")
                CATransaction.commit()
                
            case "right":
                
                CATransaction.begin()
                CATransaction.setCompletionBlock {
                    
                    if pieceX.shape == .cross && pieceX.side.right.closing.isOpen != false {
                        
                        self.model.switchCross(piece: pieceX, ball: ball)
                        self.model.board.view.bringSubviewToFront(ball.view)
                    }
                }
                self.model.moveBall(ball: ball, startSide: "left")
                CATransaction.commit()
                
            default:
                break
            }
            
            ball.view.center = self.ballEndingPoint
            return
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = ballPath.cgPath
        animation.repeatCount = 0
        animation.duration = 0.25
        ball.view.layer.add(animation, forKey: "animate along path")
        
        CATransaction.commit()
    }
}

extension ViewController: ModelDelegate {
    
    func replacePiece(piece: Piece) {
        
        let newPiece = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: piece.isLocked, opening: piece.opening, doesPivot: piece.doesPivot)
        
        let frame = CGRect(x: self.model.board.grid[piece.indexes]!.x - (pieceWidth / 2), y:  self.model.board.grid[piece.indexes]!.y - (pieceHeight / 2), width: pieceWidth, height: pieceHeight)
        let shapeView = ShapeView(frame: frame, piece: newPiece)
        
        piece.view.removeFromSuperview()
        piece.view = shapeView
        
        self.model.board.view.addSubview(piece.view)
    }
    
    func ballCrashInCross(piece: Piece, ball: Ball) {
        
        let yAxisIsAligned:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) == ball.view.center.y
        
        let xAxisIsAligned:Bool = piece.view.frame.minX + (piece.view.frame.width / 2) == ball.view.center.x
        
        let ballIsLowerTanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) < ball.view.center.y
        
        let ballIsHigherThanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) > ball.view.center.y
        
        let ballIsRightOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) < ball.view.center.x
        
        let ballIsLeftOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) > ball.view.center.x
        
        var startPoint = CGPoint()
        var endPoint = CGPoint()

//        print("yAxisIsAligned \(yAxisIsAligned)")
//        print("xAxisIsAligned \(xAxisIsAligned)")
//        print("ballIsLowerTanPieceCenter \(ballIsLowerTanPieceCenter)")
//        print("ballIsHigherThanPieceCenter \(ballIsHigherThanPieceCenter)")
//        print("ballIsRightOfPieceCenter \(ballIsRightOfPieceCenter)")
//        print("ballIsLeftOfPieceCenter \(ballIsLeftOfPieceCenter)")

        if xAxisIsAligned && ballIsLowerTanPieceCenter {
            
            //Moves the piece up
            
             startPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y - (self.pieceWidth / 2))
            
             endPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y - (self.pieceHeight / 3))
            
//            calculateAnimation(view: ball.view, beginPoint: startPoint, endPoint: endPoint, controlPoint: endPoint) { (true) in
//
//                self.animateMove(ball: ball, endSide: "center")
//
//            }
            
        } else if xAxisIsAligned && ballIsHigherThanPieceCenter {
            
            //Moves the piece down
            
             startPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y + (self.pieceWidth / 2))
            
             endPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y + (self.pieceHeight / 3))
            
//            calculateAnimation(view: ball.view, beginPoint: startPoint, endPoint: endPoint, controlPoint: endPoint) { (true) in
//
//                self.animateMove(ball: ball, endSide: "center")
//            }
            
        } else if yAxisIsAligned && ballIsRightOfPieceCenter {
            
            //Moves the piece left
            
             startPoint = CGPoint(x: ball.view.center.x - (self.pieceWidth / 2), y: ball.view.center.y)
            
             endPoint = CGPoint(x: ball.view.center.x - (self.pieceWidth / 3), y: ball.view.center.y)
            
//            calculateAnimation(view: ball.view, beginPoint: startPoint, endPoint: endPoint, controlPoint: endPoint) { (true) in
//                self.animateMove(ball: ball, endSide: "center")
//            }
            
        } else if yAxisIsAligned && ballIsLeftOfPieceCenter {
            
            //Moves the ball right
            
             startPoint = CGPoint(x: ball.view.center.x + (self.pieceWidth / 2), y: ball.view.center.y)
            
             endPoint = CGPoint(x: ball.view.center.x + (self.pieceWidth / 3), y: ball.view.center.y)
            
//            calculateAnimation(view: ball.view, beginPoint: startPoint, endPoint: endPoint, controlPoint: endPoint) { (true) in
//
//                self.animateMove(ball: ball, endSide: "center")
//            }
        }
//        self.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
        UIView.animate(withDuration: 0.125) {
            
            print("ball.center \(ball.view.center)")
            print("startPoint \(startPoint)")
            print("endPoint \(endPoint)")

            let transform = CGAffineTransform(translationX: (startPoint.x - endPoint.x) * 2, y: (startPoint.y - endPoint.y) * 2)
            
            
            ball.view.transform = transform
            

        } completion: { (true) in
            print()
//            return
        }

        
        
       
    }
    
    
    
    func removePieceAfterBall(piece: Piece) {
        
        let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        let delayedTime = DispatchTime.now() + .milliseconds(Int(500))
        
        var tempBall = Ball()
        
        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
            UIView.animate(withDuration: self.duration4Animation, delay: 0.10, options: .curveEaseInOut) {
                
                piece.view.transform = scale
                
                for ball in self.model.board.balls {
                    
                    if ball.indexes == piece.indexes {
                        ball.view.transform = scale
                        tempBall = ball
                    }
                }
            } completion: { (true) in
                
                tempBall.view.removeFromSuperview()
                piece.view.removeFromSuperview()
                piece.view.removeFromSuperview()
            }
        }
    }
    
    func removePiece(piece: Piece) {
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: duration4Animation, delay: 0.10, options: .curveEaseInOut) {
            piece.view.transform = scale

        } completion: { (true) in
            
            piece.view.removeFromSuperview()
        }
    }
    
    func removeBall(ball: Ball) {
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: duration4Animation, delay: 0.10, options: .curveEaseInOut) {
            ball.view.transform = scale

        } completion: { (true) in
            ball.view.removeFromSuperview()
        }
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
    
    func check4CrossCrash(piece: Piece, ball: Ball, startSide: String) -> Bool {
        
        var bool = false
        
        switch startSide {
        
        case "top":
            if piece.side.top.closing.isOpen == false {

                ballCrashInCross(piece: piece, ball: ball)
                bool = true
            }
        case "bottom":
            if piece.side.bottom.closing.isOpen == false {

                ballCrashInCross(piece: piece, ball: ball)
                bool = true
            }
        case "left":
            if piece.side.left.closing.isOpen == false {

                ballCrashInCross(piece: piece, ball: ball)
                bool = true
            }
        case "right":
            if piece.side.right.closing.isOpen == false {

                ballCrashInCross(piece: piece, ball: ball)
                bool = true
            }
        default:
            break
            
        }
        
        
        return bool
        
    }
    
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
        
        
        print("piece shape \(piece.shape)")
        
        if piece.shape == .cross {
            
            if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
                
                self.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                return
                
            }
            
        }
       
        print("this shouldnt have printed")
        
        var beginPoint = CGPoint()
        var endPoint = CGPoint()
        var controlPoint = CGPoint()
        self.model.board.view.bringSubviewToFront(ball.view)
        
        switch startSide {
        
        case "center":
            
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top"{
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            }
            
            beginPoint = ball.view.center
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.animateMove(ball: ball, endSide: endSide)
                                
                self.model.checkIfBallExited(ball: ball)
            }
            
        case "top":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.animateMove(ball: ball, endSide: endSide)
                
                self.model.checkIfBallExited(ball: ball)
            }
            
        case "bottom":
            
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.animateMove(ball: ball, endSide: endSide)
                self.model.checkIfBallExited(ball: ball)
            }
            
        case "left":
            
            
            if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.animateMove(ball: ball, endSide: endSide)
                self.model.checkIfBallExited(ball: ball)
            }
            
        case "right":
                        
            if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "left" {
                
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.animateMove(ball: ball, endSide: endSide)
                self.model.checkIfBallExited(ball: ball)
            }
            
        default:
            break
        }
    }
    
    func movePieces(piece: Piece, direction: UISwipeGestureRecognizer.Direction) {
        
        if piece.indexes.x! < 0{
            
            UIView.animate(withDuration: 0.25) {
                piece.view.center = CGPoint(x: piece.view.center.x - (self.distanceFromPieceCenter * 2), y: piece.view.center.y)
            }
            
            self.model.deletePiece(piece: piece)
            
        } else if piece.indexes.x! > self.model.board.widthSpaces - 1 {
            UIView.animate(withDuration: 0.25) {
                piece.view.center = CGPoint(x: piece.view.center.x + (self.distanceFromPieceCenter * 2), y: piece.view.center.y)
            }
            
            self.model.deletePiece(piece: piece)
            
        } else if piece.indexes.y! < 0 {
            
            UIView.animate(withDuration: 0.25) {
                piece.view.center = CGPoint(x: piece.view.center.x, y: piece.view.center.y - (self.distanceFromPieceCenter * 2))
            }
            
            self.model.deletePiece(piece: piece)
            
        } else if piece.indexes.y! > self.model.board.heightSpaces - 1 {
            
            UIView.animate(withDuration: 0.25) {
                piece.view.center = CGPoint(x: piece.view.center.x, y: piece.view.center.y + (self.distanceFromPieceCenter * 2))
            }
            
            self.model.deletePiece(piece: piece)
            
        } else {
            
            //Piece is on the board and therefore execute move regularly
            UIView.animate(withDuration: 0.25) {
                piece.view.center = self.model.board.grid[piece.indexes]!
                
                for ball in self.model.board.balls {
                    if ball.indexes == piece.indexes {
                        
                        ball.view.center = self.model.board.grid[ball.indexes]!
                    }
                }
            }
        }
        
        if piece.shape == .entrance {
            
            for ball in model.board.balls {
                
                if ball.indexes == piece.indexes {
                    
                    UIView.animate(withDuration: 0.25) {
                        
                        ball.view.center = piece.view.center
                        
                        self.model.deleteBall(ball: ball)
                        
                    } completion: { (true) in
                        print("Check if there are any balls still left in the game")
                    }
                }
            }
        }
    }
    
    func setUpPiecesView() {
        
        UIView.animate(withDuration: 0.25, delay: 0.5, options: .curveEaseInOut) {  [self] in
            
            for piece in model.board.pieces {
            
                let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
                piece.view = ShapeView(frame: frame, piece: piece)
                piece.view.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.view.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.view.center.y)
                addTapGestureRecognizer(view: piece.view)
                model.board.view.addSubview(piece.view)
            }
            setupBalls()
            
        } completion: { (false) in
            print()
        }
    }
    
    func runPopUpView(title: String, message: String) {
        
        if model.gameOver == true { return }
                
        let delayedTime = DispatchTime.now() + .milliseconds(Int(500))
        
        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                alert.dismiss(animated: true) {
                    
                    if title == "YOU WIN" {
                        self.model.level.number += 1
                    }
                    
                    self.ballPath = UIBezierPath()
                    self.model.resetGame()
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(25))
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                        self.boardView.removeFromSuperview()
                        self.retryButton.removeFromSuperview()
                        self.menuButton.removeFromSuperview()
                        self.model.setUpGame()
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                            //Add code here if you want something to happen after the first wait
                        }
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
                alert.dismiss(animated: true) {
                    print()
                }
            }
            alert.addAction(action)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true) {
                //completion here
            }
        }
    }
    
    func setUpGame(board: Board) {
                
        self.setSizes()
        self.setupGrid()
        self.setupBoard()
        self.setupControls()
    }
    
    func clearPiecesAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.25) {
            
            let translationX = self.model.board.grid[Indexes(x: 0, y: 0)]!.x - view.center.x
            
            let translationY = self.model.board.grid[Indexes(x: 0, y: 0)]!.x - view.center.y
            
            let transform = CGAffineTransform(translationX: translationX, y: translationY)
            
            view.transform = transform
            
        } completion: { (true) in

//            self.removePiece(piece: piece)
        }
    }
}




