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
    var piecesViews = [Piece]()
    var spaceViews = [UIView]()
    var pieceWidth = CGFloat()
    var pieceHeight = CGFloat()
    var boardWidth = CGFloat()
    var boardHeight = CGFloat()
    var degrees = 90.0
    var piecesWereEnlarged = false
    var distanceFromPieceCenter = CGFloat()
    var ballPath = UIBezierPath()
    var piecesCrossed:Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        model = Model(view: self.view)
        model.delegate = self
        model.setUpGame()
        addSwipeGestureRecognizer(view: model.board.view)
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
    
    func resetSpaces() {
        
        for space in spaceViews {
            
            space.backgroundColor = .black
        }
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
    

    
    func curveAnimation(view: UIView, beginPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint, completion: (Bool) -> Void) {
//
//        print("beginPoint \(beginPoint)")
//        print("controlPoint \(controlPoint)")
//        print("endPoint \(endPoint)")
//
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
        for piece in piecesViews.sorted(by: { (piece1, piece2) -> Bool in
            piece1.view.center.y < piece2.view.center.y
        }).filter({ (piece) -> Bool in
            piece is Entrance == false
        }) {
                        
            let height = (piece.view.frame.height / 9 * 10)
            let width = (piece.view.frame.width / 9 * 10)
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
    
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
        
        enlargePieces()
        
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
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                                
                ballPath = UIBezierPath()
                
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
            
            if endSide == "left" {
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "bottom" {
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in

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
            
            if endSide == "left" {
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            } else if endSide == "right" {
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            } else if endSide == "top" {
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
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
            
            if endSide == "bottom" {
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "right" {
                endPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                

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
            
            if endSide == "bottom" {
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            } else if endSide == "top" {
                endPoint = CGPoint(x: piece.view.center.x, y: piece.view.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
            } else if endSide == "left" {
                endPoint = CGPoint(x: piece.view.center.x - self.distanceFromPieceCenter, y: piece.view.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
            }
            
            beginPoint = CGPoint(x: piece.view.center.x + self.distanceFromPieceCenter, y: piece.view.center.y)
            controlPoint = piece.view.center
            
            self.curveAnimation(view: ball.view, beginPoint: beginPoint, endPoint: endPoint, controlPoint: controlPoint) { (true) in
                
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
    
    func animatePiece(piece: Piece) {
        
        UIView.animate(withDuration: 1.0, animations: {
            for spaceView in self.spaceViews {
                
                if spaceView.center == CGPoint(x: self.model.board.grid[piece.indexes]!.x, y: self.model.board.grid[piece.indexes]!.y) {
                    
                    spaceView.backgroundColor = .purple
                }
            }
        }) { (true) in
            self.resetSpaces()
        }
    }
    
    func movePieces() {
        
        for piece in model.board.pieces {
            
            UIView.animate(withDuration: 0.25) {
                piece.view.center = self.model.board.grid[piece.indexes]!
            }
        }
    }
    
    func setUpPiecesView() {
                
        for piece in model.board.pieces.filter({ (piece) -> Bool in
            piece is Entrance == false && piece is Exit == false && piece is Wall == false
        }) {
            
            let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
            piece.view = ShapeView(frame: frame, piece: piece)
            piece.view.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.view.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.view.center.y)
//            piece.view.layer.borderColor = UIColor.white.cgColor
//            piece.view.layer.borderWidth = 2.0
            addTapGestureRecognizer(view: piece.view)
            self.piecesViews.append(piece)
            model.board.view.addSubview(piece.view)
            
            //MARK: Change the pieces to bubbles
//            piece.view.layer.cornerRadius = piece.view.frame.height / 2
        }
    }
    
    func setupEntrances() {
                
        for piece in self.model.board.pieces {
            
            if piece is Entrance {
                
//                piece.colors.append(UIColor.black)

                
                let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
                
                piece.view = ShapeView(frame: frame, piece: piece)
                piece.view.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.view.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.view.center.y)
                piece.view.backgroundColor = .blue
                addTapGestureRecognizer(view: piece.view)
                self.piecesViews.append(piece)
                model.board.view.addSubview(piece.view)
                
                let widthAndHeight = pieceWidth / 4.5
                var x = CGFloat()
                var y = CGFloat()
                
                if let piece = piece as? Entrance {
                    
                    switch piece.opening {

                    
                    case "top":
                        
                        x = frame.midX - (widthAndHeight / 2)
                        y = 0
                        
                    case "bottom":
                        
                        x = frame.midX - (widthAndHeight / 2)
                        y = frame.maxY - widthAndHeight
                        
                    case "left":
                        
                        x = 0
                        y = frame.midY - (widthAndHeight / 2)
                        
                    case "right":
                        
                        x = frame.maxX - widthAndHeight
                        y = frame.midY - (widthAndHeight / 2)
                        
                    default:
                        break
                    }
                    
                    let rect = CGRect(x: x, y: y, width: widthAndHeight, height: widthAndHeight)
                    let openingView = UIView(frame: rect)
                    openingView.backgroundColor = .black
                    piece.view.addSubview(openingView)
                    
                    let halfFrame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight / 2)
                    let textBox = UITextField(frame: halfFrame)
                    textBox.text = "Begin"
                    textBox.textColor = .white
                    textBox.textAlignment = .center
                    piece.view.addSubview(textBox)
                    
                    self.model.board.view.addSubview(piece.view)
                }
            }
        }
    }
    
    func setupExits() {
        
        for piece in self.model.board.pieces {
            
            if piece is Exit {
                
//                piece.colors.append(UIColor.black)
                
                let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
                piece.view = ShapeView(frame: frame, piece: piece)
                piece.view.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.view.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.view.center.y)
                piece.view.backgroundColor = .blue
                addTapGestureRecognizer(view: piece.view)
                self.piecesViews.append(piece)
                model.board.view.addSubview(piece.view)
                
                let widthAndHeight = pieceWidth / 4.5
                var x = CGFloat()
                var y = CGFloat()
                
                if let piece = piece as? Exit {

                    switch piece.opening {
                    
                    case "top":
                        
                        x = frame.midX - (widthAndHeight / 2)
                        y = 0
                        
                    case "bottom":
                        
                        x = frame.midX - (widthAndHeight / 2)
                        y = frame.maxY - widthAndHeight
                        
                    case "left":
                        
                        x = 0
                        y = frame.midY - (widthAndHeight / 2)
                        
                    case "right":
                        
                        x = frame.maxX - widthAndHeight
                        y = frame.midY - (widthAndHeight / 2)
                        
                    default:
                        break
                    }
                    
                    let rect = CGRect(x: x, y: y, width: widthAndHeight, height: widthAndHeight)
                    let openingView = UIView(frame: rect)
                    openingView.backgroundColor = .black
                    piece.view.addSubview(openingView)
                    
                    let halfFrame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight / 2)
                    let textBox = UITextField(frame: halfFrame)
                    textBox.text = "End"
                    textBox.textColor = .white
                    textBox.textAlignment = .center
                    piece.view.addSubview(textBox)
                    
                    self.model.board.view.addSubview(piece.view)
                
                }
            }
        }
    }
    
    func setupWalls() {
        
        for piece in self.model.board.pieces {
            
            if piece is Wall {
                
//                piece.colors.append(UIColor.lightGray)
                let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
                piece.view = ShapeView(frame: frame, piece: piece)
                piece.view.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.view.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.view.center.y)
                piece.view.backgroundColor = .lightGray
                addTapGestureRecognizer(view: piece.view)
                self.piecesViews.append(piece)
                model.board.view.addSubview(piece.view)
                self.model.board.view.addSubview(piece.view)
            }
        }
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
        
        let frameX = self.view.frame.midX - (boardWidth / 2)
        let frameY = self.view.frame.midY - (boardHeight / 2)
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
        
        let boardView = BoardView(frame: frame, xArray: xArray, yArray: yArray)
        self.model.board.view = boardView
        self.model.board.view.backgroundColor = .black
        view.addSubview(self.model.board.view)
    }
    
    func setSizes() {

        let widthCushion:CGFloat = (model.board.view.frame.width / 10)
        let heightCushion:CGFloat = (model.board.view.frame.height / 10)
        
        if self.model.board.view.frame.width < (self.model.board.view.frame.height / 2) {
            
            boardHeight = (model.board.view.frame.width - widthCushion) * 2
            boardWidth = model.board.view.frame.width - widthCushion

        } else if self.model.board.view.frame.width > (self.model.board.view.frame.height / 2) {
        
            boardWidth = (model.board.view.frame.height - heightCushion) / 2
            boardHeight = model.board.view.frame.height - heightCushion
        }
        
        pieceWidth = boardWidth / CGFloat(model.level.boardWidth) / 10 * 9
        pieceHeight = boardHeight / CGFloat(model.level.boardHeight) / 10 * 9
        
        distanceFromPieceCenter = (pieceWidth / 9 * 10) / 2
    }
    
    func setUpGame(board: Board) {
                
        setSizes()

        setupGrid()
        
        setupBoard()

        setupEntrances()
        
        setupExits()
        
        setupWalls()
        
        setupBalls()
    }
    
    func setupGrid() {

        let frameX = (self.model.board.view.frame.width - boardWidth) / 2
        let frameY = (self.model.board.view.frame.height - boardHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
        self.model.board.widthSpaces = self.model.level.boardWidth
        self.model.board.heightSpaces = self.model.level.boardHeight
        self.model.board.grid = GridPoints(frame: frame, height: self.model.board.heightSpaces, width: self.model.board.widthSpaces).getGrid()
    }

    
    func pieceWasTapped(piece: Piece) {
        
        piece.view.setNeedsDisplay()
    }
}




