//
//  LoadingView.swift
//  Pontucao da cidade
//
//  Created by Paulo Henrique on 16/01/2018.
//  Copyright © 2018 Paulo Henrique. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingView: UIView {

    static func showLoading() {
        
        if let viewController = UIViewController.topViewController {
            let snapShot = viewController.view.snapshot.applyBlur(withRadius: 4, tintColor: nil, saturationDeltaFactor: 1, maskImage: nil)
            let alert = UIView()
            alert.frame = viewController.view.bounds
            let imageView = UIImageView(frame: viewController.view.frame)
            imageView.image = snapShot
            alert.addSubview(imageView)
            
            let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .ballScaleMultiple, color: StyleKit.colors.appColor.withAlphaComponent(0.3), padding: 1.0)
            activityIndicator.center = viewController.view.center
            activityIndicator.startAnimating()
            alert.tag = 67777
            alert.addSubview(activityIndicator)
            viewController.view.addSubview(alert)
            
        }
        
    }

}
