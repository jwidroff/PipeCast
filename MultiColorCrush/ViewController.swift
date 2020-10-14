//
//  ViewController.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/10/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var board = Board()
    var model = Model()
    var piecesViews = [Piece]()
    var spaceViews = [UIView]()
    var spaceWidth = CGFloat()
    var spaceHeight = CGFloat()
    var degrees = 90.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = Model(view: self.view)
        model.delegate = self
        model.setUpGame()
        addSwipeGestureRecognizer(view: board.view)
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



//FIX THE PIECES ARE CONNECTED ALREADY
extension ViewController: ModelDelegate {


    func animatePiece(piece: Piece) {
        
        UIView.animate(withDuration: 1.0, animations: {
            for spaceView in self.spaceViews {
                
                if spaceView.center == CGPoint(x: self.board.grid[piece.indexes]!.x, y: self.board.grid[piece.indexes]!.y) {
                    
                    spaceView.backgroundColor = .purple
                }
            }
        }) { (true) in
            self.resetSpaces()
        }
    }
    
    
    func movePieces() {
        
        for piece in board.pieces {
            
            UIView.animate(withDuration: 0.25) {
                piece.view.center = self.board.grid[piece.indexes]!
            }
        }
    }
    
    func setUpPiecesView() {
        
        let pieceWidth = spaceWidth //* 0.90
        let pieceHeight = spaceHeight //* 0.90
        
        for piece in board.pieces {
            
            let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
            piece.view = ShapeView(frame: frame, color: piece.color.cgColor, shape: piece.shape)
            piece.view.center = CGPoint(x: board.grid[piece.indexes]?.x ?? piece.view.center.x, y: board.grid[piece.indexes]?.y ?? piece.view.center.y)
            piece.view.layer.opacity = 1.0
            
            
            
            
            piece.view.layer.borderColor = UIColor.white.cgColor
            piece.view.layer.borderWidth = 2.0

//            piece.view.layer.shadowOpacity = 1
//            piece.view.layer.shadowPath = CGPath(rect: piece.view.bounds, transform: nil)
//            piece.view.layer.shadowColor = UIColor.white.cgColor
//            piece.view.layer.shadowOffset = CGSize(width: 1, height: 1)
//            piece.view.layer.shadowRadius = 5

            addTapGestureRecognizer(view: piece.view)
            self.piecesViews.append(piece)
            board.view.addSubview(piece.view)
        }
    }
    
    func setupEntrances() {
        
//        let spaceWidth = self.board.view.frame.width / 100 * 20
//        let spaceHeight = self.board.view.frame.width / 100 * 20
        
        for entrance in self.board.entrances {
            
            let widthAndHeight = spaceWidth / 10

            let frame = CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight)
            let entranceView = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: .regular)
            entranceView.center = CGPoint(x: board.grid[entrance.indexes]?.x ?? entrance.view.center.x, y: board.grid[entrance.indexes]?.y ?? entrance.view.center.y)
            entranceView.backgroundColor = .yellow
            
            var x = CGFloat()
            var y = CGFloat()

            switch entrance.opening {

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
            entranceView.addSubview(openingView)
            
            let halfFrame = CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight / 2)
            let textBox = UITextField(frame: halfFrame)
            textBox.text = "Begin"
            textBox.textColor = .white
            textBox.textAlignment = .center
            entranceView.addSubview(textBox)
            
            self.board.view.addSubview(entranceView)
        }
        
        
    }
    
    func setupExits() {
        
//        let spaceWidth = self.board.view.frame.width / 100 * 20
//        let spaceHeight = self.board.view.frame.width / 100 * 20
        
        for exit in self.board.exits {
            
            let frame = CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight)

            let exitView = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: .regular)
            
            exitView.center = CGPoint(x: board.grid[exit.indexes]?.x ?? exit.view.center.x, y: board.grid[exit.indexes]?.y ?? exit.view.center.y)

            exitView.backgroundColor = .green
            //append walls
            
            
            let widthAndHeight = spaceWidth / 10
            var x = CGFloat()
            var y = CGFloat()

            
            switch exit.opening {

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
            exitView.addSubview(openingView)

            let textBox = UITextField(frame: frame)
            textBox.text = "End"
            textBox.textColor = .white
            textBox.textAlignment = .center
            exitView.addSubview(textBox)
            
            self.board.view.addSubview(exitView)
        }
        
        
        
        
        
    }
    
    func setupWalls() {
        
//        let spaceWidth = self.board.view.frame.width / 100 * 20
//        let spaceHeight = self.board.view.frame.width / 100 * 20
        
        for wall in self.board.walls {
            
            let frame = CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight)
            let wallView = UIView(frame: frame)
            wallView.center = CGPoint(x: board.grid[wall.indexes]?.x ?? wall.view.center.x, y: board.grid[wall.indexes]?.y ?? wall.view.center.y)

            wallView.backgroundColor = .gray
            
            wallView.layer.cornerRadius = wallView.frame.height / 2

            self.board.view.addSubview(wallView)
            
        }
        
        
        
    }
    
    func setupBalls() {
        
//        let spaceWidth = self.board.view.frame.width / 100 * 20
//        let spaceHeight = self.board.view.frame.width / 100 * 20
        
        for ball in self.board.balls {
            
            let frame = CGRect(x: 0, y: 0, width: spaceWidth, height: spaceHeight)

            ball.view = ShapeView(frame: frame, color: UIColor.black.cgColor, shape: .ball)
            
            ball.view.center = CGPoint(x: board.grid[ball.indexes]?.x ?? ball.view.center.x, y: board.grid[ball.indexes]?.y ?? ball.view.center.y)
            
            addTapGestureRecognizer(view: ball.view)

            self.board.view.addSubview(ball.view)
        }
        
        
        
        
    }
    
    func setupSpaces() {
        
//        let spaceWidth = self.board.view.frame.width / 100 * 20
//        let spaceHeight = self.board.view.frame.width / 100 * 20
        for point in self.board.grid {
                        
            let pointX = point.value.x
            let pointY = point.value.y
            let frame = CGRect(x: pointX, y: pointY, width: spaceWidth, height: spaceHeight)
            let spaceView = UIView(frame: frame)
            spaceView.frame = frame
            spaceView.center = point.value
            spaceView.backgroundColor = .black
            spaceView.layer.borderColor = UIColor.white.cgColor
            spaceView.layer.borderWidth = 2.0
            spaceView.layer.opacity = 0.5
            spaceViews.append(spaceView)
            self.board.view.addSubview(spaceView)
        }
        
        
        
    }
    
    func setupBoard() {
        
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        self.board.view = UIView(frame: frame) //as! BoardView
//        let boardView = BoardView(frame: frame, xArray: board.grid, yArray: <#T##[CGFloat]#>)
        
                
//        self.board.view.frame = frame
        
//        let boardView = BoardView(frame: frame, xArray: , yArray: <#T##[CGFloat]#>)
        
        
        var xArray = [CGFloat]()
        var yArray = [CGFloat]()
        
        
        for point in self.board.grid.values {
                        
            let pointX = point.x
            xArray.append(pointX)
            let pointY = point.y
            yArray.append(pointY)
            
        }
        
        
        let boardView = BoardView(frame: frame, xArray: xArray, yArray: yArray)
        
        self.board.view = boardView
        
        
        
        
        
        
        
        
        
        
        
        
        self.board.view.backgroundColor = .black
        view.addSubview(self.board.view)
    }
    
    func setSizes() {
        
        
        
        //TODO: Pick up here and set the space width and height (in a new property in the Board) to be used for the setEntrance, setExits, setWalls... etc
        
        
        spaceWidth = self.board.view.frame.width / 100 * 20
        spaceHeight = self.board.view.frame.width / 100 * 20
        
        
        
        
        
        
        
        
    }
    
    func setUpGame(board: Board) {
                
        self.board = board
        
        
        
        
        setupBoard()

        setSizes()
        
//        setupSpaces()
        
        setupEntrances()
        
        setupExits()
        
        setupWalls()
        
        setupBalls()
    }

    
    func moveBall(startIndex: Indexes, endIndex: Indexes, exitingSide: String) {
        
        if startIndex.y! > endIndex.y! {
                        
            print("headed up because y index is smaller")

            for ball in board.balls {
                
                if ball.indexes == startIndex {
                    
                    UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                        
                        self.board.view.bringSubviewToFront(ball.view)
                        let translationY = self.board.grid[endIndex]!.y - self.board.grid[startIndex]!.y
                        ball.view.center = CGPoint(x: ball.view.center.x, y: ball.view.center.y + translationY)
                                                
                    }) { (true) in
                        
                        print("we should be entering the bottom side of the new piece")
                        
                        self.model.moveBallAgain(ball: ball, enteringSide: "bottom")
                        return
                    }
                }
            }
        }
        
        if startIndex.y! < endIndex.y! {
            
            print("headed down because y index is bigger")

            for ball in board.balls {
                
                if ball.indexes == startIndex {
                    
                    UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                        
                        self.board.view.bringSubviewToFront(ball.view)

                        let translationY = self.board.grid[endIndex]!.y - self.board.grid[startIndex]!.y
                        
                        ball.view.center = CGPoint(x: ball.view.center.x, y: ball.view.center.y + translationY)
                        
                    }) { (true) in
                        
                        print("we should be entering the top side of the new piece")
                        
                        self.model.moveBallAgain(ball: ball, enteringSide: "top")
                        return
                    }
                }
            }
        }
       
        if startIndex.x! > endIndex.x! {
            
            print("headed left because x index is smaller")
            
            for ball in board.balls {
                
                if ball.indexes == startIndex {
                    
                    UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                        
                        self.board.view.bringSubviewToFront(ball.view)

                        let translationX = self.board.grid[endIndex]!.x - self.board.grid[startIndex]!.x
                                                
                        ball.view.center = CGPoint(x: ball.view.center.x + translationX, y: ball.view.center.y)
                        
                    }) { (true) in
                        
                        print("we should be entering the right side of the new piece")
                        
                        self.model.moveBallAgain(ball: ball, enteringSide: "right")
                        return
                    }
                }
            }
        }
        
        if startIndex.x! < endIndex.x! {
            
            print("headed right because x index is bigger")

            
            for ball in board.balls {
                
                if ball.indexes == startIndex {
                    
                    UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                        
                        self.board.view.bringSubviewToFront(ball.view)

                        let translationX = self.board.grid[endIndex]!.x - self.board.grid[startIndex]!.x

                        ball.view.center = CGPoint(x: ball.view.center.x + translationX, y: ball.view.center.y)
                        
                        
                    }) { (true) in
                        
                        print("we should be entering the left side of the new piece")
                        
                        self.model.moveBallAgain(ball: ball, enteringSide: "left")
                        return
                        
                        
                        
                    }
                }
            }
        }
    }
    
    func pieceWasTapped(piece: Piece) {

        //TODO: Make it that the pieces all get "glued together" and also move this function to a better place
        
//        for spaceView in spaceViews {
//
//            let center = spaceView.center
//            spaceView.frame = CGRect(x: 0, y: 0, width: self.board.view.frame.width / 100 * 90, height: self.board.view.frame.width / 100 * 90)
//            spaceView.center = center
//            spaceView.setNeedsDisplay()
//        }
        
        piece.view.setNeedsDisplay()
    }
    
}




