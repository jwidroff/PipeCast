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
    var gridPoints = [Indexes: CGPoint]()
    var dotView = Piece()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        board.grid = GridPoints(frame: board.view.frame, height: 10, width: 5).getGrid()
        
        gridForVisual()
        
        addGamePiece()
        
        addGestureRecognizer(view: board.view)
        
    }

    func addGamePiece() {
        
        //TODO: Up to this. Fill in the Pieces other properties

        let dotWidth = board.view.frame.width / 100 * 15
        let dotHeight = board.view.frame.width / 100 * 15
        let point = board.grid[Indexes(x: 1, y: 1)]
        let frame = CGRect(x: 0, y: 0, width: dotWidth, height: dotHeight)
        dotView.view = UIView(frame: frame)
        dotView.view.frame = frame
        dotView.view.center = point ?? CGPoint(x: 100, y: 100)
        dotView.view.backgroundColor = .green
        board.view.addSubview(dotView.view)
    }
    
    func addGestureRecognizer(view: UIView) {
        
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
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer) {
        
        switch sender.direction {
            
        case .up:
            dotView.view.center = board.grid[Indexes(x: 0, y: 0)]!
        case .down:
            dotView.view.center = board.grid[Indexes(x: 4, y: 1)]!
        case .right:
            dotView.view.center = board.grid[Indexes(x: 1, y: 4)]!
        case .left:
            dotView.view.center = board.grid[Indexes(x: 1, y: 7)]!
        default:
            break
        }

    }
    
    func gridForVisual() {
        
        for point in board.grid {
            
            print(point)
            
            let dotWidth = board.view.frame.width / 100 * 10
            let dotHeight = board.view.frame.width / 100 * 10
            let pointX = point.value.x
            let pointY = point.value.y
            let frame = CGRect(x: pointX, y: pointY, width: dotWidth, height: dotHeight)
            let dotView = UIView(frame: frame)
            dotView.frame = frame
            dotView.center = point.value
            dotView.backgroundColor = .black
            board.view.addSubview(dotView)
        }
        
    }
    
    func setupView() {
        
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        board.view.frame = frame
        board.view.backgroundColor = .red
        view.addSubview(board.view)
    }
}

