//
//  Extension+UITextField.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

extension UITextField {
    
    @IBInspectable
    var blanckSpace: Bool {
        get {
            if let bkView = self.leftView {
                if bkView.tag == 111111 {
                    return true
                }
            }
            return false
        }
        set (newValue) {
            if newValue {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
                view.backgroundColor = .clear
                view.tag = 111111
                self.leftView = view
                self.leftViewMode = .always
            }
        }
    }
    
}
