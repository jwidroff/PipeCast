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
    var piecesWereEnlarged = false
    var distanceFromPieceCenter = CGFloat()
    var ballPath = UIBezierPath()
    var deviceIsNarrow = Bool()
    var retryButton = UIButton()
    var menuButton = UIButton()
    var widthCushion = CGFloat()
    var heightCushion = CGFloat()
    var colorTheme = ColorTheme()
    var boardView = UIView()
    var ballEndingPoint = CGPoint()
    var duration4Animation = 0.25
    var swipesLeftLabel = UILabel()
    var levelNameLabel = UILabel()
    var levelObjectiveLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = colorTheme.gameBackground
        model = Model()
        model.delegate = self
        model.setUpGame()
    }
    
    //MARK: Initial Setup
    func setupGrid() {

//        if deviceIsNarrow {
//
//
//            let frameX = (self.model.board.view.frame.width - boardWidth) / 2
//            let frameY = (self.model.board.view.frame.height - boardHeight) / 2
//            let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
//            self.model.board.grid = GridPoints(frame: frame, height: self.model.board.heightSpaces, width: self.model.board.widthSpaces).getGrid()
//
//
//        } else {
            
            
            let frameX = (self.model.board.view.frame.width - boardWidth) / 2
            let frameY = (self.model.board.view.frame.height - boardHeight) / 2
            let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
            self.model.board.grid = GridPoints(frame: frame, height: self.model.board.heightSpaces, width: self.model.board.widthSpaces).getGrid()
            
            
//        }
        
        
       
    }
    
    func setupBalls() {
                
        for ball in self.model.board.balls {
            
            let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
            ball.view = BallView(frame: frame)
            ball.center = CGPoint(x: model.board.grid[ball.indexes]?.x ?? ball.view.center.x, y: model.board.grid[ball.indexes]?.y ?? ball.view.center.y)
            ball.view.center = ball.center
            addTapGestureRecognizer(view: ball.view)
            self.model.board.view.addSubview(ball.view)
        }
    }
    
    func setupBoard() {
        
        var frameY = CGFloat()
        
        if deviceIsNarrow {

            frameY = self.view.frame.midY - (boardHeight / 2) + (heightCushion / 4)
            
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
            
            boardWidth = (self.view.frame.height - (heightCushion / 2)) / 2
            boardHeight = (self.view.frame.height - (heightCushion / 2))
            
            print("Wide Device")
            deviceIsNarrow = false

        } else if self.view.frame.width < (self.view.frame.height / 2) {
        
            boardHeight = (self.view.frame.width - (widthCushion * 2)) * 2
            boardWidth = self.view.frame.width - (widthCushion * 2)
            
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
        var swipesLeftLabelFrame = CGRect()
        var levelNameLabelFrame = CGRect()
        var levelObjectiveLabelFrame = CGRect()
        
        

        if deviceIsNarrow == true {
                        
            let buttonWidth = (boardWidth / 2) - 10
            let buttonHeight = heightCushion / 2
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
            
            
            let swipesLeftLabelHeight = heightCushion / 4
            let swipesLeftLabelWidth = (boardWidth / 2) - 10
            let swipesLeftYFloat = model.board.view.frame.minY - swipesLeftLabelHeight - 10
            let swipesLeftXFloat = model.board.view.frame.minX
            let swipesLeftLabelFrame = CGRect(x: swipesLeftXFloat, y: swipesLeftYFloat, width: swipesLeftLabelWidth, height: swipesLeftLabelHeight)
            
            swipesLeftLabel.frame = swipesLeftLabelFrame
            swipesLeftLabel.backgroundColor = .clear
            swipesLeftLabel.textAlignment = .left
            swipesLeftLabel.text = "SWIPES LEFT: "
            view.addSubview(swipesLeftLabel)
            
            
            let levelObjectiveLabelHeight = heightCushion / 4
            let levelObjectiveLabelWidth = (boardWidth / 2) - 10
            let levelObjectiveYFloat = model.board.view.frame.minY - swipesLeftLabelHeight - 10
            let levelObjectiveXFloat = model.board.view.frame.minX + (boardWidth / 2) + 10
            let levelObjectiveLabelFrame = CGRect(x: levelObjectiveXFloat, y: levelObjectiveYFloat, width: levelObjectiveLabelWidth, height: levelObjectiveLabelHeight)
            
            levelObjectiveLabel.frame = levelObjectiveLabelFrame
            levelObjectiveLabel.backgroundColor = .clear
            levelObjectiveLabel.textAlignment = .right
            levelObjectiveLabel.text = "[LEVEL OBJECTIVE]"
            view.addSubview(levelObjectiveLabel)
            
            
            let levelNameLabelHeight = heightCushion / 2
            let levelNameLabelWidth = boardWidth
            let levelNameYFloat = model.board.view.frame.minY - swipesLeftLabelHeight - levelNameLabelHeight - 20
            let levelNameXFloat = model.board.view.frame.minX
            let levelNameLabelFrame = CGRect(x: levelNameXFloat, y: levelNameYFloat, width: levelNameLabelWidth, height: levelNameLabelHeight)
            levelNameLabel.frame = levelNameLabelFrame
            levelNameLabel.backgroundColor = .blue
            levelNameLabel.textAlignment = .center
            levelNameLabel.text = "[LEVEL NAME HERE]"
            view.addSubview(levelNameLabel)
            
            
            
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
            
            
            //UP TO HERE. JUST FINISHED THE SWIPES LEFT LABEL
            
            let levelNameLabelWidth = model.board.view.frame.minX / 4 * 3
            let levelNameLabelHeight = levelNameLabelWidth * 2

            let levelNameYFloat = model.board.view.frame.minY
            let levelNameXFloat = model.board.view.frame.minX - (model.board.view.frame.minX / 8) - buttonWidth
            let levelNameLabelFrame = CGRect(x: levelNameXFloat, y: levelNameYFloat, width: levelNameLabelWidth, height: levelNameLabelHeight)
            
            levelNameLabel.frame = levelNameLabelFrame
            levelNameLabel.backgroundColor = .blue
            levelNameLabel.textAlignment = .left
            levelNameLabel.text = "[LEVEL NAME]"
            view.addSubview(levelNameLabel)
            
            let swipesLeftLabelWidth = model.board.view.frame.minX / 4 * 3
            let swipesLeftLabelHeight = swipesLeftLabelWidth * 2

            let swipesLeftYFloat = model.board.view.frame.minY + levelNameLabelHeight + 10
            let swipesLeftXFloat = model.board.view.frame.minX - (model.board.view.frame.minX / 8) - buttonWidth
            let swipesLeftLabelFrame = CGRect(x: swipesLeftXFloat, y: swipesLeftYFloat, width: swipesLeftLabelWidth, height: swipesLeftLabelHeight)

            swipesLeftLabel.frame = swipesLeftLabelFrame
            swipesLeftLabel.backgroundColor = .blue
            swipesLeftLabel.textAlignment = .left
            swipesLeftLabel.text = "SWIPES LEFT: "
            view.addSubview(swipesLeftLabel)
            
  
            let levelObjectiveLabelWidth = model.board.view.frame.minX / 4 * 3
            let levelObjectiveLabelHeight = ((levelObjectiveLabelWidth * 2) * 2) + 10

            let levelObjectiveYFloat = model.board.view.frame.minY
            let levelObjectiveXFloat = model.board.view.frame.maxX + (model.board.view.frame.minX / 8)
            let levelObjectiveLabelFrame = CGRect(x: levelObjectiveXFloat, y: levelObjectiveYFloat, width: levelObjectiveLabelWidth, height: levelObjectiveLabelHeight)

            levelObjectiveLabel.frame = levelObjectiveLabelFrame
            levelObjectiveLabel.backgroundColor = .green
            levelObjectiveLabel.textAlignment = .left
            levelObjectiveLabel.text = "[GAME OBJECTIVE]"
            view.addSubview(levelObjectiveLabel)
            
            
            
            
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
                        
        runPopUpView(title: "", message: "Are you sure you want to restart?")
    }
    
    @objc func handleTap4Menu(sender: UITapGestureRecognizer) {
        
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
    
    func animateMove(ball: Ball, endSide: String) {
                
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            
            self.moveBallAgain(ball: ball, endSide: endSide)
            return
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = ballPath.cgPath
        animation.repeatCount = 0
        animation.duration = duration4Animation
        ball.view.layer.add(animation, forKey: "animate along path")
        CATransaction.commit()
    }
    
    func moveBallAgain(ball: Ball, endSide: String) {
        
        ball.center = self.ballEndingPoint
        ball.view.center = ball.center
        
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
}

extension ViewController: ModelDelegate {

    func changeAnimationSpeed(slowerOrFaster: String) {
        
        switch slowerOrFaster {
        
        case "faster":
            
            if duration4Animation > 0.02 {
                
                duration4Animation -= 0.02
            }
                        
        case "slower":
            
            duration4Animation = 0.25
            
        default:
            break
        }
    }
    
    func changeViewColor(piece: Piece, ball: Ball) {
        
        var backgroundColor = UIColor.systemYellow
        
        if ball.loopedIndexes[piece.indexes] == 1 {
            
            backgroundColor = UIColor.orange
            
        } else if ball.loopedIndexes[piece.indexes] == 2 {
            
            backgroundColor = UIColor.red

        } else if ball.loopedIndexes[piece.indexes] == 3 {
            
            backgroundColor = UIColor.purple

        } else if ball.loopedIndexes[piece.indexes] == 4 {
            
            backgroundColor = UIColor.systemIndigo
        }
        
        piece.view.backgroundColor = backgroundColor
        
        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))

        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
            piece.view.backgroundColor = .clear
        }
    }
    
    func replacePieceView(piece: Piece) {
        
        if self.model.board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == piece.indexes
        }) {
            
            let newPiece = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: piece.isLocked, opening: piece.opening, doesPivot: piece.doesPivot)
            
            let frame = CGRect(x: self.model.board.grid[piece.indexes]!.x - (self.pieceWidth / 2), y:  self.model.board.grid[piece.indexes]!.y - (self.pieceHeight / 2), width: self.pieceWidth, height: self.pieceHeight)
            
            let shapeView = ShapeView(frame: frame, piece: newPiece)
            piece.view.removeFromSuperview()
            piece.view = shapeView
            self.addTapGestureRecognizer(view: piece.view)
            self.model.board.view.addSubview(piece.view)
            
            for ball in self.model.board.balls {
                
                self.model.board.view.bringSubviewToFront(ball.view)
            }
        }
    }
    
    func crashBallViewIntoCross(piece: Piece, ball: Ball) {
        
        let yAxisIsAligned:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) == ball.center.y
        let xAxisIsAligned:Bool = piece.view.frame.minX + (piece.view.frame.width / 2) == ball.center.x
        let ballIsLowerTanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) < ball.center.y
        let ballIsHigherThanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) > ball.center.y
        let ballIsRightOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) < ball.center.x
        let ballIsLeftOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) > ball.center.x
        var startPoint = CGPoint()
        var endPoint = CGPoint()

        if xAxisIsAligned && ballIsLowerTanPieceCenter {
            
            //Moves the piece up
             startPoint = CGPoint(x: ball.center.x, y: ball.center.y - (self.pieceWidth / 2))
             endPoint = CGPoint(x: ball.center.x, y: ball.center.y - (self.pieceHeight / 3))
            
        } else if xAxisIsAligned && ballIsHigherThanPieceCenter {
            
            //Moves the piece down
             startPoint = CGPoint(x: ball.center.x, y: ball.center.y + (self.pieceWidth / 2))
             endPoint = CGPoint(x: ball.center.x, y: ball.center.y + (self.pieceHeight / 3))
            
        } else if yAxisIsAligned && ballIsRightOfPieceCenter {
            
            //Moves the piece left
             startPoint = CGPoint(x: ball.center.x - (self.pieceWidth / 2), y: ball.center.y)
             endPoint = CGPoint(x: ball.center.x - (self.pieceWidth / 3), y: ball.center.y)
            
        } else if yAxisIsAligned && ballIsLeftOfPieceCenter {
            
            //Moves the ball right
             startPoint = CGPoint(x: ball.center.x + (self.pieceWidth / 2), y: ball.center.y)
             endPoint = CGPoint(x: ball.center.x + (self.pieceWidth / 3), y: ball.center.y)
        }
        
        UIView.animate(withDuration: 0.125) {
            
            let transform = CGAffineTransform(translationX: (startPoint.x - endPoint.x) * 2, y: (startPoint.y - endPoint.y) * 2)
            ball.view.transform = transform
            
        } completion: { (true) in
            print()
        }
    }
    
    func removeView(view: UIView) {
        
        let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))

        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
            UIView.animate(withDuration: self.duration4Animation, delay: 0.0, options: .curveEaseInOut) {
                
                view.transform = scale

            } completion: { (true) in

                view.removeFromSuperview()
            }
        }
    }
    
//    func removeBall(ball: Ball) {
//        
//        let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
//        
//        UIView.animate(withDuration: duration4Animation, delay: 0.10, options: .curveEaseInOut) {
//            ball.view.transform = scale
//
//        } completion: { (true) in
//            ball.view.removeFromSuperview()
//        }
//    }
    
    func resetPieceMakerView(piece: Piece) {
 
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
    
//    func check4CrossCrash(piece: Piece, ball: Ball, startSide: String) -> Bool {
//
//        //TODO: Move this to the Model
//
//        var bool = false
//
//        switch startSide {
//
//        case "top":
//            if piece.side.top.closing.isOpen == false {
//
//                ballCrashInCross(piece: piece, ball: ball)
//                bool = true
//            }
//        case "bottom":
//            if piece.side.bottom.closing.isOpen == false {
//
//                ballCrashInCross(piece: piece, ball: ball)
//                bool = true
//            }
//        case "left":
//            if piece.side.left.closing.isOpen == false {
//
//                ballCrashInCross(piece: piece, ball: ball)
//                bool = true
//            }
//        case "right":
//            if piece.side.right.closing.isOpen == false {
//
//                ballCrashInCross(piece: piece, ball: ball)
//                bool = true
//            }
//        default:
//            break
//
//        }
//        return bool
//    }
    
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
        
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
            
            beginPoint = ball.center
            
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
            
        default:
            break
        }
        
        controlPoint = piece.view.center
        ballPath.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        ballPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        ballEndingPoint = endPoint
        ball.center = ballEndingPoint
        animateMove(ball: ball, endSide: endSide)
    }
    
    func movePieceView(piece: Piece) {
        
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
                        
                        ball.center = piece.view.center
                        ball.view.center = ball.center
                        self.model.deleteBall(ball: ball)
                        
                    } completion: { (true) in
                        print()
                    }
                }
            }
        }
    }
    
    func setUpPiecesView() {
        
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseInOut) {  [self] in
            
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
        
        if model.gameOver == true {
            model.gameOver = false
            return
        }
        
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
                    
                    self.model.gameOver = false
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
            print()
        }
    }
}




