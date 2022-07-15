//
//  UIViewController+Ext.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 6/24/22.
//

import UIKit

fileprivate var containerView: UIView!


extension UIViewController {
    
    
    func showLoadingview() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8  }
        
        let activatyIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activatyIndicator)
        
        activatyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activatyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activatyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activatyIndicator.startAnimating()
    }
    
    func dismissLoding() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
}
