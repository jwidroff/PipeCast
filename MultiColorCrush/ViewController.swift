//
//  ViewController.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 8/10/20.
//  Copyright © 2020 Jeffery Widroff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameBoardView = UIView()
    var gridPoints = [Indexes: CGPoint]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        
        gridPoints = GridPoints(frame: gameBoardView.frame, height: 5, width: 5).getGrid()
        
        for point in gridPoints {
            
            let pointX = point.value.x
            let pointY = point.value.y
            
            let frameWidth = view.frame.width / 10 * 1
            let frameHeight = view.frame.width / 10 * 1
            let frame = CGRect(x: pointX, y: pointY, width: frameWidth, height: frameHeight)
            let dotView = UIView(frame: frame)
            
            dotView.frame = frame
            dotView.backgroundColor = .black
            view.addSubview(dotView)
        }
    }

    func setupView() {
        
        let frameWidth = view.frame.width / 10 * 9
        let frameHeight = view.frame.height / 10 * 9
        let frameX = (view.frame.width - frameWidth) / 2
        let frameY = (view.frame.height - frameHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        gameBoardView.frame = frame
        gameBoardView.backgroundColor = .red
        view.addSubview(gameBoardView)
    }
}

