//
//  City.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 16/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

class City: NSObject {

    var name: String?
    var stateName: String?
    
    init(withName name: String, stateName: String) {
        super.init()
        self.name = name
        self.stateName = stateName
    }
    
}
