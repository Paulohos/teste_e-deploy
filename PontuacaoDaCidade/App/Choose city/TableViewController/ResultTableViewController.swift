//
//  ResultTableViewController.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    var arrayResultCities: [City]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.removeFooterView()
    }
    
    private func request(city: City) {
        self.showLoading {
            _ = Connection.executeResquest(request: .searchForScore(name: city.name!, state: city.stateName!)).addCallback(callback: { (result) -> (Void) in
                print(result.data)
                if result.code == 200 {
                    if let score = result.data["data"] as? Double {
                        self.performSegue(withIdentifier: "segueScore", sender: score)
                    }
                    self.hiddenLoading(handle: nil)
                } else {
                    self.hiddenLoading(handle: {
                        self.showAlertErrorWith("", "Whoops...algo deu errado.", handleButtons: nil)
                    })
                }
            }).run()
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueScore"{
            guard let viewController = segue.destination as? ScoreTableViewController else {return}
            let indexPath = self.tableView.indexPathForSelectedRow
            let city = self.arrayResultCities![indexPath!.row]
            viewController.city = city
            viewController.score = sender as? Double
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayResultCities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as! ResultTableViewCell
        let city = self.arrayResultCities![indexPath.row]
        cell.cityLabel.text = city.name
        cell.stateLabel.text = city.stateName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = self.arrayResultCities![indexPath.row]
        self.request(city: city)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }

}
