//
//  PaymentMethodViewModel.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation
import UIKit

protocol PaymentMethodViewModelView: BaseViewModel {
    func showPaymentMethods(data: [PaymentModel])
}

protocol PaymentMethodViewModelDelegate {
    func getPaymentMethods()
}

class PaymentMethodViewModel: PaymentMethodViewModelDelegate {
    
    weak var view: PaymentMethodViewModelView?
    var service: CardsServiceProtocol?

    init(view: PaymentMethodViewModelView, service: CardsServiceProtocol?) {
        self.view = view
        self.service = service
    }

    func getPaymentMethods() {
        self.view?.showLoader()
        
        service?.getCardData(completion: { (response, error) in
            self.view?.hideLoader()
            if error != nil {
                self.view?.showAlert(title: "Error", message: error?.localizedDescription ?? "")
            } else {
                guard let paymentResponse = response else { return }
                
                self.view?.showPaymentMethods(data: paymentResponse)
            }
        })
    }    
}
