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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupView()
        
        print("loaded")
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

