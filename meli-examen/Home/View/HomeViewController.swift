//
//  HomeViewController.swift
//  meli-examen
//
//  Created by juan ledesma on 11/30/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit
import Kingfisher

protocol PaymentReceivedProtocol {
    func setPaymentResult(paymentResult: TestModel?)
}


class HomeViewController: BaseViewController {

    var viewModel: PaymentModelViewController?
    var delegate: PaymentReceivedProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inicio"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @IBAction func btnComenzarPressed(_ sender: UIButton) {
        self.viewModel = PaymentModelViewController()
        Router.pushPaymentAmountViewController(viewController: self, viewModel: viewModel, delegate: self)
    }
}

extension HomeViewController: PaymentReceivedProtocol {
    func setPaymentResult(paymentResult: TestModel?) {
        let vc = GenericAlert()
        self.parent?.addChild(vc)
        vc.view.frame = self.parent?.view.frame ?? CGRect()
        self.parent?.view.addSubview(vc.view)
        vc.lblMonto.text = paymentResult?.amount
        vc.lblPayMethod.text = paymentResult?.creditCardName

        let cardUrl = URL(string: paymentResult?.creditCardUrl ?? "")
        vc.imgPayMethod.kf.setImage(with: cardUrl)

        vc.lblBank.text = paymentResult?.bankName
        let bankUrl = URL(string: paymentResult?.bankUrl ?? "")
        vc.imgBank.kf.setImage(with: bankUrl)
        vc.lblCuota.text = paymentResult?.installments
        
    }
}
