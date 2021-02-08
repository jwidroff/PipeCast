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
    var deviceIsNarrow = Bool()
    var retryButton = UIButton()
    var menuButton = UIButton()
    var widthCushion = CGFloat()
    var heightCushion = CGFloat()
    var colorTheme = ColorTheme()
    var boardView = UIView()
    var ballEndingPoint = CGPoint()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = colorTheme.gameBackground
        model = Model()
        model.delegate = self
        model.setUpGame()
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
        
//        self.model.board.view.layer.borderColor = UIColor.red.cgColor
//        self.model.board.view.layer.borderWidth = 2.0

        view.addSubview(self.model.board.view)
    }
    
    func setSizes() {
        
        //FIX THIS. DOESNT WORK WELL FOR IPHONE 7, 8
        
        
        //TODO: UP TO HERE - PRINT THE DIFFERENT SCREEN SIZES AND FIGURE ALGORITHM TO ACCOMIDATE ALL
        
        

        
        
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
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        widthCushion = (self.view.frame.width / CGFloat(model.board.widthSpaces * 2))
//        heightCushion = (self.view.frame.height / CGFloat(model.board.heightSpaces))
//
//        if self.view.frame.width > (self.view.frame.height / 2.5) {
//
//
//            boardWidth = (self.view.frame.height - heightCushion) / 2
//            boardHeight = self.view.frame.height - heightCushion
//
//            print("Wide Device")
//            deviceIsNarrow = false
//
//        } else if self.view.frame.width < (self.view.frame.height / 2.5) {
//
//
//
//            boardHeight = (self.view.frame.width - widthCushion) * 2
//            boardWidth = self.view.frame.width - widthCushion
//
//            print("Narrow Device")
//            deviceIsNarrow = true
//        }
//
//        pieceWidth = boardWidth / CGFloat(model.board.widthSpaces) / 10 * 9
//        pieceHeight = boardHeight / CGFloat(model.board.heightSpaces) / 10 * 9
//        distanceFromPieceCenter = (pieceWidth / 9 * 10) / 2
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
    
    func calculateAnimation(view: UIView, beginPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint, completion: @escaping (Bool) -> Void) {

        ballPath.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        ballPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        piecesCrossed += 0.25
        ballEndingPoint = endPoint
        completion(true)
    }
    
    func animateMove(ball: Ball){
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = ballPath.cgPath
        animation.repeatCount = 0
        animation.duration = piecesCrossed
        ball.view.layer.add(animation, forKey: "animate along path")
        ball.view.center = ballEndingPoint
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
    
    @objc func handleTap4Retry(sender: UITapGestureRecognizer) {
                        
        print("Handling Tap 4 retry")
        runPopUpView(title: "", message: "Are you sure you want to restart?")
    }
    
    @objc func handleTap4Menu(sender: UITapGestureRecognizer) {
        
        print("Handling Tap 4 menu")
//        runPopUpView(title: "TEST", message: "THIS IS ONLY A TEST")
        
        
        runMenuView()
        
    }
    
    func runMenuView() {
        
        
        
        
        let width = self.view.frame.width / 10 * 9
        let height = self.view.frame.height / 10 * 9
        let x = (self.view.frame.width - width) / 2
        let y = (self.view.frame.height - height) / 2


        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        let menuView = MenuView(frame: frame)
        
        view.addSubview(menuView)
        
        
    }
    
    
    
    func makeViewSoft(view: UIView) {
        
        //MARK: This needs to be adjusted.
        
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
    
    func radians(degrees: Double) ->  CGFloat {
        
        return CGFloat(degrees * .pi / degrees)
    }
}

extension ViewController: ModelDelegate {

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
            
            calculateAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
            }
            
        } else if xAxisIsAligned && ballIsHigherThanPieceCenter {
            
            //Moves the piece down
            let endPoint = CGPoint(x: ball.view.center.x, y: ball.view.center.y + (self.pieceHeight / 4 * 3 / 2))
            
            calculateAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
            }
            
        } else if yAxisIsAligned && ballIsRightOfPieceCenter {
            
            //Moves the piece left
            let endPoint = CGPoint(x: ball.view.center.x - (self.pieceWidth / 4 * 3 / 2), y: ball.view.center.y) 
            
            calculateAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
            }
            
        } else if yAxisIsAligned && ballIsLeftOfPieceCenter {
            
            //Moves the ball right
            let endPoint = CGPoint(x: ball.view.center.x + (self.pieceWidth / 4 * 3 / 2), y: ball.view.center.y)
            
            calculateAnimation(view: ball.view, beginPoint: ball.view.center, endPoint: endPoint, controlPoint: endPoint) { (false) in
            }
        }
        
        runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
    }
    
    func removePiece(piece: Piece) {
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseInOut) {
            piece.view.transform = scale

        } completion: { (true) in
            piece.view.removeFromSuperview()

        }
    }
    
    func removeBall(ball: Ball) {
        
        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseInOut) {
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
    
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
        
        var beginPoint = CGPoint()
        var endPoint = CGPoint()
        var controlPoint = CGPoint()
        self.model.board.view.bringSubviewToFront(ball.view)
        
        switch startSide {
        
        case "center":
            
//            print("start side = center")
            
            if endSide == "left" {
//                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
//                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top"{
//                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "bottom" {
//                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            }
            
            beginPoint = ball.view.center
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                                
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
            
//            print("start side = top")
            
            if endSide == "left" {
//                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
//                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "bottom" {
//                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "center" {
//                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
                self.changePieceAfterBallMoves(piece: piece)
                
//                if piece.shape != .cross {
//
//                    let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//
////                    piece.isLocked = true
//
//                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                        var version = Int()
//                        if piece.version == 1 {
//                            version = 0
//                        } else if piece.version == 0 {
//                            version = 1
//                        }
//
//                        let pieceX = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: version, currentSwitch: piece.currentSwitch, isLocked: true, opening: nil, doesPivot: false)
//                        let view = ShapeView(frame: piece.view.frame, piece: pieceX)
//
//                        piece.view.removeFromSuperview()
//
//                        piece.view = view
//
//                        self.model.board.view.addSubview(piece.view)
//
//                        piece.view.setNeedsDisplay()
//
//                    }
//
//                } else if piece.shape == .cross {
//
//                    self.model.switch4Tap(piece: piece) { (true) in
//
//                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//                        let backgroundColor = piece.view.backgroundColor?.cgColor
//
//                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor
//
//                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
//
//                                piece.view.layer.backgroundColor = backgroundColor
//                                piece.view.setNeedsDisplay()
//                            }
//                        }
//                    }
//                }
                
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
            
//            print("start side = bottom")

            if endSide == "left" {
//                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
//                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top" {
//                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "center" {
//                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                  
                
                self.changePieceAfterBallMoves(piece: piece)

                
//                if piece.shape != .cross {
//
//                    let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//
////                    piece.isLocked = true
//
//                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                        let pieceX = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: true, opening: nil, doesPivot: false)
//                        let view = ShapeView(frame: piece.view.frame, piece: pieceX)
//
//                        piece.view.removeFromSuperview()
//
//                        piece.view = view
//
//                        self.model.board.view.addSubview(piece.view)
//
//                        piece.view.setNeedsDisplay()
//
//                    }
//
//                } else if piece.shape == .cross {
//
//                    self.model.switch4Tap(piece: piece) { (true) in
//
//                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//                        let backgroundColor = piece.view.backgroundColor?.cgColor
//
//                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor
//
//                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
//
//                                piece.view.layer.backgroundColor = backgroundColor
//                                piece.view.setNeedsDisplay()
//                            }
//                        }
//                    }
//                }
                
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
            
//            print("start side = left")

            if endSide == "bottom" {
//                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
//                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "right" {
//                print("end side = right")

                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "center" {
//                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                         
                self.changePieceAfterBallMoves(piece: piece)

                
                
//                if piece.shape != .cross {
//
//                    let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//
////                    piece.isLocked = true
//
//                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                        let pieceX = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: true, opening: nil, doesPivot: false)
//                        let view = ShapeView(frame: piece.view.frame, piece: pieceX)
//
//                        piece.view.removeFromSuperview()
//
//                        piece.view = view
//
//                        self.model.board.view.addSubview(piece.view)
//
//                        piece.view.setNeedsDisplay()
//
//                    }
//
//                } else if piece.shape == .cross {
//
//                    self.model.switch4Tap(piece: piece) { (true) in
//
//                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//                        let backgroundColor = piece.view.backgroundColor?.cgColor
//
//                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor
//
//                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
//
//                                piece.view.layer.backgroundColor = backgroundColor
//                                piece.view.setNeedsDisplay()
//                            }
//                        }
//                    }
//                }
                
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
            
//            print("start side = right")

            if endSide == "bottom" {
//                print("end side = bottom")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
//                print("end side = top")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "left" {
//                print("end side = left")

                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "center" {
//                print("end side = center")

                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.calculateAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                       
                
                self.changePieceAfterBallMoves(piece: piece)

                
                
//                if piece.shape != .cross {
//
//                    let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//
////                    piece.isLocked = true
//
//                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                        let pieceX = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: true, opening: nil, doesPivot: false)
//                        let view = ShapeView(frame: piece.view.frame, piece: pieceX)
//
//                        piece.view.removeFromSuperview()
//
//                        piece.view = view
//
//                        self.model.board.view.addSubview(piece.view)
//
//                        piece.view.setNeedsDisplay()
//
//                    }
//
//                } else if piece.shape == .cross {
//
//                    self.model.switch4Tap(piece: piece) { (true) in
//
//                        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
//                        let backgroundColor = piece.view.backgroundColor?.cgColor
//
//                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
//
//                            piece.view.layer.backgroundColor = UIColor.lightGray.cgColor
//
//                            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
//
//                                piece.view.layer.backgroundColor = backgroundColor
//                                piece.view.setNeedsDisplay()
//                            }
//                        }
//                    }
//                }
                
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
        animateMove(ball: ball)
    }
    
    func changePieceAfterBallMoves(piece: Piece) {
        
        
        if piece.shape != .cross {
            
            let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
            
//                    piece.isLocked = true
            
            DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                
                var version = Int()
                if piece.version == 1 {
                    version = 0
                } else if piece.version == 0 {
                    version = 1
                }
                
                let pieceX = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: true, opening: nil, doesPivot: false)
                let view = ShapeView(frame: piece.view.frame, piece: pieceX)
                
                piece.view.removeFromSuperview()
                
                piece.view = view
                
                self.model.board.view.addSubview(piece.view)
                
                piece.view.setNeedsDisplay()
                
            }
            
        } else if piece.shape == .cross {
            
            self.model.switch4Tap(piece: piece) { (true) in
                
                let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
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
                    ball.view.center = self.model.board.grid[ball.indexes]!
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
        
        //WORK ON THIS ANIMATION
        
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
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: true) {
                
               

                self.ballPath = UIBezierPath()
                self.piecesCrossed = 0.0
                self.model.resetGame()
                
                
//                self.model.setUpGame()
//
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
        
        let delayedTime = DispatchTime.now() + .milliseconds(Int(self.piecesCrossed * 1000))
        DispatchQueue.main.asyncAfter(deadline: delayedTime) {

            self.present(alert, animated: true) {
                //completion here
            }
            DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                //Add code here if you want something to happen after the first wait
            }
        }
    }
    
    func setUpGame(board: Board) {
                
//        self.boardView.removeFromSuperview()
//        self.retryButton.removeFromSuperview()
//        self.menuButton.removeFromSuperview()
//
        
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
    
    
    func pieceWasTapped(piece: Piece) {
        
        piece.view.setNeedsDisplay()
    }
}




