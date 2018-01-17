//
//  Extension+String.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 16/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

extension String {
    
    //MARK: - Properts
    var trimming: String {
        
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
    }
}
