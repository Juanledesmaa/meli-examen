//
//  PaymentDueViewController.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit

class PaymentDueViewController: BaseViewController {

    @IBOutlet weak var pickerTextField: PickerTextField!
    var installments = [PaymentDueModel]()
    var viewModel: PaymentDueViewModelDelegate?
    private let picker = UIPickerView()
    var selectedInstallment: PaymentDueModel?
    var viewModelController: PaymentModelViewController?
    var delegate: PaymentReceivedProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pago por cuotas"
        self.configurePicker()
        self.viewModel?.getInstallments(payment: self.viewModelController?.paymentData)

    }
    
    private func configurePicker(){
        picker.delegate = self
        picker.dataSource = self
        self.pickerTextField.delegate = self
        self.pickerTextField.inputView = picker
    }
    

    
    @IBAction func btnFinalizarPressed(_ sender: CustomButton) {
        self.viewModelController?.paymentData.installments = self.selectedInstallment?.recommended_message ?? ""
        self.dismiss(animated: true) {
            self.delegate?.setPaymentResult(paymentResult: self.viewModelController?.paymentData)
        }

    
    }
    

}

extension PaymentDueViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return installments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.installments[row].recommended_message
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerTextField.text = self.installments[row].recommended_message
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.pickerTextField:
            let selectedValue = self.picker.selectedRow(inComponent: 0)
            self.selectedInstallment = self.installments[selectedValue]
            self.pickerTextField.text = self.selectedInstallment?.recommended_message
        default:
            break
        }
    }
}

extension PaymentDueViewController: PaymentDueViewModelView {
    func showInstallments(data: [PaymentDueModel]) {
        self.installments = data
        
        guard !(self.installments.isEmpty) else {
            let alert = UIAlertController(title: "Alerta", message: "No hay metodo de pago en cuotas para el banco seleccionado. Intente con otro", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        picker.reloadAllComponents()

    }
    
}

