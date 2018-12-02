//
//  PaymentDueViewModel.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation

protocol PaymentDueViewModelView: BaseViewModel {
    func showInstallments(data: [PaymentDueModel])
}

protocol PaymentDueViewModelDelegate {
    func getInstallments(payment: TestModel?)
}

class PaymentDueViewModel: PaymentDueViewModelDelegate {

    weak var view: PaymentDueViewModelView?
    var service: CardsServiceProtocol?
    
    init(view: PaymentDueViewModelView, service: CardsServiceProtocol?) {
        self.view = view
        self.service = service
    }
    
    func getInstallments(payment: TestModel?) {
        self.view?.showLoader()
        
        service?.getInstallments(request: payment ?? TestModel(amount: "", cardId: "", creditCardUrl: "", creditCardName: "", bankId: "", bankUrl: "", bankName: "", installments: "") , completion: { (response, error) in
            self.view?.hideLoader()
            
            if error != nil {
                self.view?.showAlert(title: "Error", message: error?.localizedDescription ?? "")
            } else {
                guard let installmentResponse = response else { return }
                self.view?.showInstallments(data: installmentResponse)
            }
        })
    }
}

