//
//  Router.swift
//  meli-examen
//
//  Created by juan ledesma on 11/30/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation
import UIKit

class Router: NSObject {
    
    private static var window: UIWindow? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.window
    }
    
    static func setRootViewController(viewController: UIViewController) {
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
    }
    
    static func presentMainViewController() {
        let vc = HomeViewController()
        NavStyle.setupNavBarAppearance()
        setRootViewController(viewController: vc)
    }
    
    static func pushPaymentAmountViewController(viewController: UIViewController, viewModel: PaymentModelViewController?, delegate: PaymentReceivedProtocol?) {

        guard let model = viewModel else { return }
        let vc = PaymentAmountViewController()
        vc.delegate = delegate
        let navController: UINavigationController = UINavigationController(rootViewController: vc)
        vc.viewModelController = model
        viewController.present(navController, animated: true) {
            
        }
    }
    
    static func pushPaymentMethodViewController(viewModel: PaymentModelViewController?, viewController: UIViewController, delegate: PaymentReceivedProtocol?) {
        let vc = PaymentMethodViewController()
        let service: CardsServiceProtocol? = ServiceLocator.sharedInstance.get(service: CardsServiceProtocol.self)
        vc.viewModel = PaymentMethodViewModel(view: vc, service: service)
        vc.viewModelController = viewModel
        vc.delegate = delegate
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func pushPaymentBankViewController(viewModel: PaymentModelViewController?, viewController: UIViewController, delegate: PaymentReceivedProtocol?) {
        let vc = PaymentBankViewController()
        let service: CardsServiceProtocol? = ServiceLocator.sharedInstance.get(service: CardsServiceProtocol.self)
        vc.viewModel = PaymentBankViewModel(view: vc, service: service)
        vc.viewModelController = viewModel
        vc.delegate = delegate
        viewController.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static func pushPaymentDueViewController(viewModel: PaymentModelViewController?, viewController: UIViewController, delegate: PaymentReceivedProtocol?) {
        let vc = PaymentDueViewController()
        let service: CardsServiceProtocol? = ServiceLocator.sharedInstance.get(service: CardsServiceProtocol.self)
        vc.viewModel = PaymentDueViewModel(view: vc, service: service)
        vc.viewModelController = viewModel
        vc.delegate = delegate
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
