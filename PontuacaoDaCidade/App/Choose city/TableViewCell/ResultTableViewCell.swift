//
//  ResultTableViewCell.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var stateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let cityColor = cityView.backgroundColor
        let stateColor = stateView.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if(selected) {
            cityView.backgroundColor = cityColor
            stateView.backgroundColor = stateColor
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let cityColor = cityView.backgroundColor
        let stateColor = stateView.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        
        if(highlighted) {
            cityView.backgroundColor = cityColor
            stateView.backgroundColor = stateColor
        }
    }

}
