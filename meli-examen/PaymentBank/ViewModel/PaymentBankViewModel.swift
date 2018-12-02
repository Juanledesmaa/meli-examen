//
//  PaymentBankViewModel.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation

protocol PaymentBankViewModelView: BaseViewModel {
    func showBanks(data: [PaymentBankModel])
}

protocol PaymentBankViewModelDelegate {
    func getBanks(method: String)
}

class PaymentBankViewModel: PaymentBankViewModelDelegate {
    weak var view: PaymentBankViewModelView?
    var service: CardsServiceProtocol?
    init(view: PaymentBankViewModelView, service: CardsServiceProtocol?) {
        self.view = view
        self.service = service
    }

    func getBanks(method: String) {
        self.view?.showLoader()
        
        service?.getBankData(method: method, completion: { (response, error) in
            self.view?.hideLoader()
            
            if error != nil {
                self.view?.showAlert(title: "Error", message: error?.localizedDescription ?? "")
            } else {
                guard let bankResponse = response else { return }
                self.view?.showBanks(data: bankResponse)
            }
        })
    }
}

