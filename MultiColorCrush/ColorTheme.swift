//
//  ColorTheme.swift
//  MultiColorCrush
//
//  Created by Jeffery Widroff on 1/8/21.
//  Copyright © 2021 Jeffery Widroff. All rights reserved.
//

import Foundation
import UIKit



class ColorTheme {
    
    var gameBackground = UIColor()
    var boardBackground = UIColor()
    var pieceBackground = UIColor()
    var lockedPieceBackground = UIColor()
    var holeColor = UIColor()
    var gridLineColor = UIColor()
    var lockPieceScrewColor = UIColor()
    var buttonColors = UIColor()
    var buttonTextColor = UIColor()
    
    init() {
        
        gameBackground = UIColor.black
        boardBackground = UIColor.lightGray
        pieceBackground = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        lockedPieceBackground = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0)
        lockPieceScrewColor = UIColor.black
        holeColor = UIColor.black
        gridLineColor = UIColor.black
        buttonColors = UIColor.white
        buttonTextColor = UIColor.black
        //Wall Color
        //cross divider color
        //Piece outline color
        //Cross switch color
        
    }
    
    
}






