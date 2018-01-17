//
//  ScoreTableViewController.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!

    var score: Double?
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.removeFooterView()
        self.scoreLabel.text = "A pontuação da cidade de \(self.city!.name!) é \(self.score!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
