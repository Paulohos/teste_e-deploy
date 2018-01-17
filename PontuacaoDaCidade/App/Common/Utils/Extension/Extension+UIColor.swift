//
//  Extension+UIColor.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hexaCor:Int) {
        
        self.init(red:(hexaCor >> 16) & 0xff, green:(hexaCor >> 8) & 0xff, blue:hexaCor & 0xff)
    }
    
}
