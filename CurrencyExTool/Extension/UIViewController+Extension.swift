//
//  UIViewController+Extension.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    final func showHud(_ title : String? = nil , message : String? = nil){

        let hudView = LoadingHudView.instanceFromNib()
        hudView.loadingTitleLabel.text = title
        hudView.loadingMessageLabel.text = message
        hudView.loadingActivity.startAnimating()

        self.view.addSubview(hudView)

        hudView.translatesAutoresizingMaskIntoConstraints = false
        hudView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        hudView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        hudView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        hudView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    final func hideHud(){
        self.view.subviews.forEach {
            if $0 is LoadingHudView{
                $0.removeFromSuperview()
            }
        }
    }

    //
    final func topViewController() -> UIViewController?{
        return sequence(first: self) {$0.presentedViewController }.reversed().first
    }

    // MARK: showAlert
    final func showAlert(_ title : String , errorMessage: String = "") {
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Confirm", style: .cancel, handler: nil)
        alertController.addAction(okAction)

        if let topVC = topViewController(){
            topVC.present(alertController, animated: true, completion: nil)
        }


    }
}
