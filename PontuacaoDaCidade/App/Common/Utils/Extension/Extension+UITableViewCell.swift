//
//  Extension+UITableViewCell.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    @IBInspectable
    var clearSelection: Bool {
        get {
            if let bkView = self.selectedBackgroundView {
                if bkView.backgroundColor == .white && bkView.alpha == 0.1 {
                    return true
                }
            }
            
            return false
        }
        
        set (newValue){
            if newValue {
                self.changeSelectColorCell(color: .white, withApha: 0.1)
            }
        }
    }
    
    func changeSelectColorCell(color : UIColor, withApha: CGFloat) -> Void {
        let bgColorView = UIView()
        bgColorView.backgroundColor = color.withAlphaComponent(withApha);
        self.selectedBackgroundView = bgColorView
        
    }
}
