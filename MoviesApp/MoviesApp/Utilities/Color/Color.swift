//
//  Color.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/26/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit
import HexColors

enum Color: String {
    
    case orange = "F95942"
    
    var color : UIColor {
        return UIColor.hx_color(withHexRGBAString: self.rawValue)!
    }
}

