//
//  StyleKit.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

struct StyleKit {
    
    static func initialize() {
        //UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        UIApplication.shared.isStatusBarHidden = false
      
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for: UIBarMetrics.default)
        
    }
    
    struct colors {
        static let cityCellColor = UIColor(hexaCor: 0xE5E5E5)
        static let stateCellColor = UIColor(hexaCor: 0xEBEBF1)
        static let appColor = UIColor(hexaCor: 0x013A8D)

        
    }
    
}
