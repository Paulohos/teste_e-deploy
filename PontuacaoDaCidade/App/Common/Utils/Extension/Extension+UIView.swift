//
//  Extension+UIView.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: - IBInspectable
    @IBInspectable
    var roundCorners: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set (newValue) {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var shadow:Bool {
        get {
            return layer.shadowRadius > 0
        }
        set (newValue) {
            if newValue {
                
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.2
                self.layer.shadowOffset = CGSize(width: 2, height: 2)
                self.layer.shadowRadius = 4
                self.layer.masksToBounds = false
                
                //self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
                //self.layer.shouldRasterize = true
                
            } else {
                layer.shadowRadius = 0
                layer.shadowOpacity = 0
            }
        }
    }
    
    //MARK: - Properties
    var snapshot:UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        self.layer.render(in: ctx!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
