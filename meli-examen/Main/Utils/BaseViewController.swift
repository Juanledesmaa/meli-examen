//
//  BaseViewController.swift
//  meli-examen
//
//  Created by juan ledesma on 11/30/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewModel: class {
    func showLoader()
    func hideLoader()
    func showAlert(title: String, message: String)
    func popViewController()
}

enum DismissType {
    case pop
    case dismiss
    case direct
}

class BaseViewController: UIViewController,UIGestureRecognizerDelegate, BaseViewModel {
    
    var activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
    
    struct Constants {
        static let backInsents : UIEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        static let offSetWidth: CGFloat = 19
        static let offSetHeight: CGFloat = 31
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingActivityIndicator()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    fileprivate func settingActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        activityIndicator.color = UIColor.gray
        activityIndicator.backgroundColor = UIColor.white
        activityIndicator.layer.cornerRadius = 8
    }
    
    @objc func backButtonClicked(sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func showLoader() {
        self.view.bringSubviewToFront(activityIndicator)
        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        self.view.sendSubviewToBack(activityIndicator)
        self.view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let vc = GenericAlert()
        self.addChild(vc)
        
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}
