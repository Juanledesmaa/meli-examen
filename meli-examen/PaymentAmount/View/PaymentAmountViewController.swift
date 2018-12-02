//
//  PaymentAmountViewController.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit

class PaymentAmountViewController: BaseViewController {

    @IBOutlet weak var btnContinuar: CustomButton!
    @IBOutlet weak var amountTextField: UITextField!
    var viewModelController: PaymentModelViewController?
    var delegate: PaymentReceivedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Monto"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelClicked(sender:)))
        self.amountTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func CancelClicked(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
        
        if textField.text != "" {
            self.btnContinuar.alpha = 1.0
            self.btnContinuar.isEnabled = true
        } else {
            self.btnContinuar.alpha = 0.5
            self.btnContinuar.isEnabled = false
        }
    }
    @IBAction func btnContinuarPressed(_ sender: UIButton) {
        if let amountString = self.amountTextField.text?.currencyInputFormatting() {
            self.viewModelController?.paymentData.amount = amountString.replacingOccurrences(of: "$", with: "")

        } else {
            return
        }
        Router.pushPaymentMethodViewController(viewModel: self.viewModelController, viewController: self, delegate: delegate)
    }
    

}
