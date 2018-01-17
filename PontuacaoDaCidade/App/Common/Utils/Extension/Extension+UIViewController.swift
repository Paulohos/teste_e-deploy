//
//  Extension+UIViewController.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 16/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: - Properties
    static var topViewController: UIViewController? {
        var top = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = top?.presentedViewController {
            top = presentedViewController
        }
        
        return top
    }
    
    //MARK: - Funcs
    func showLoading(handle: (()->())?) {
        
        DispatchQueue.main.async {
            LoadingView.showLoading()
            handle?()
        }
        
    }
    
    func hiddenLoading(handle: (()->())?){
        
        DispatchQueue.main.async {
            if let viewController = UIViewController.topViewController {
                if let loadingView = viewController.view.viewWithTag(67777) {
                    loadingView.removeFromSuperview()
                }
            }
            handle?()
        }
    }
    
    func showAlertErrorWith(_ title: String,_ message: String, handleButtons: ((_ buttonConfirm: Bool)->Void)?) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionConfirm = UIAlertAction(title: "OK", style: .cancel) { (_) in
            handleButtons?(true)
        }
        alert.addAction(actionConfirm)
        self.present(alert, animated: true, completion: nil)
    }
    
}
