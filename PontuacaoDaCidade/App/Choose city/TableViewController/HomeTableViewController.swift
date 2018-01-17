//
//  HomeTableViewController.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 15/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    fileprivate let limitLength: Int = 20
    private var arrayCities: [City]?
    
    //MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    //MARK: - Actions
    @IBAction func actionSearch(_ sender: UIButton) {
        
        if isValidFiels() {
            if self.arrayCities == nil {
                self.requestAllCities()
                
            } else {
                self.handleCities()
            }
            
        } else {
            self.showAlertErrorWith("", "Digite a cidade e estado", handleButtons: nil)
        }
        self.endEditingMode()

    }
    
    @IBAction func actionTriggered(_ sender: UITextField) {
        
        if sender == self.cityTextField {
            if self.stateTextField.text == "" {
                self.stateTextField.becomeFirstResponder()

            } else {
                self.endEditingMode()
                self.requestAllCities()
            }
        } else {
            self.endEditingMode()
            self.requestAllCities()
        }
        
    }
    
    //MARK: - Request
    private func requestAllCities(){
        self.showLoading {
            _ = Connection.executeResquest(request: .getAllCities()).addCallback { (result) -> (Void) in
                
                let showErrorAlert = { (_ message: String) in
                    self.hiddenLoading(handle: {
                        self.showAlertErrorWith("", message, handleButtons: nil)
                    })
                }
                
                if result.code == 200 {
                    if let arrayResult = result.data["data"] as? [[String : String]] {
                        self.arrayCities = [City]()
                        for info in arrayResult {
                            if let stateName = info["Estado"], let cityName = info["Nome"]{
                                let city = City(withName: cityName, stateName: stateName)
                                self.arrayCities!.append(city)
                            }
                        }
                        self.handleCities()
                    }
                    self.hiddenLoading(handle: nil)
                } else {
                    showErrorAlert("Whoops...algo deu errado.")
                }
                
                }.run()
        }
    }
    
    private func handleCities(){
        if self.arrayCities!.count <= 0 {
            self.hiddenLoading(handle: {
                self.showAlertErrorWith("", "Whoops...algo deu errado.", handleButtons: nil)
            })
            
        } else {
            let filterArray = self.filterCities()
            if filterArray != nil && filterArray!.count > 0 {
                self.performSegue(withIdentifier: "segueToResult", sender: filterArray)
                
            } else {
                self.hiddenLoading(handle: {
                    self.showAlertErrorWith("", "Nenhuma cidade encontrada.", handleButtons: nil)
                })
            }
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToResult"{
            guard let viewController = segue.destination as? ResultTableViewController else {return}
            viewController.arrayResultCities = sender as? [City]
        }
    }
    
    //MARK: -
    private func setup(){
        self.tableView.removeFooterView()
        self.tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.endEditingMode))
        self.tableView.addGestureRecognizer(tap)
    }
    
    @objc private func endEditingMode(){
        self.view.endEditing(true)

    }
    
    private func filterCities() -> [City]?{
        
        let cityText = self.cityTextField.text!.trimming.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        let stateText = self.stateTextField.text!.trimming.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        let arrayFilterCt = self.arrayCities?.filter({ (city) -> Bool in
            let cityName = city.name!.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            let cityStateName = city.stateName!.folding(options: .diacriticInsensitive, locale: .current).lowercased()
            if !cityText.isEmpty && !stateText.isEmpty {
                if cityName.contains(cityText) && cityStateName.contains(stateText) {
                    return true
                }
            } else if !cityText.isEmpty {
                if cityName.contains(cityText) {
                    return true
                }
            } else {
                if cityStateName.contains(stateText) {
                    return true
                }
            }
            return false
        })
        
        return arrayFilterCt
    }
    
    //MARK: - Validade fields
    private func isValidFiels() -> Bool {
        if !self.stateTextField.text!.trimming.isEmpty || !self.cityTextField.text!.trimming.isEmpty{
            return true
        }
        return false
    }
    
    //MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count
        return newLength <= limitLength
    }
}

