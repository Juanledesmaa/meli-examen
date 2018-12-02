//
//  PaymentBankViewController.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit

class PaymentBankViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var banks = [PaymentBankModel]()
    var viewModel: PaymentBankViewModelDelegate?
    var viewModelController: PaymentModelViewController?
    var delegate: PaymentReceivedProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seleccionar banco"
        self.setupTableView()
        self.viewModel?.getBanks(method: self.viewModelController?.paymentData.cardId ?? "")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.clearTableViewOnAppearance()
    }
    
    private func setupTableView() {
        self.tableView.register(methodTableViewCell.nib, forCellReuseIdentifier: methodTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func clearTableViewOnAppearance() {
        for indexPath in tableView.indexPathsForSelectedRows ?? [] {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

extension PaymentBankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: methodTableViewCell.identifier) as? methodTableViewCell else {
            return methodTableViewCell()
        }
        
        let bank = self.banks[indexPath.row]
        let url = URL(string: bank.secure_thumbnail)
        cell.imgMethod.kf.setImage(with: url)
        cell.lblMethod.text = bank.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = self.banks[indexPath.row]
        self.viewModelController?.paymentData.bankName = bank.name
        self.viewModelController?.paymentData.bankUrl = bank.secure_thumbnail
        self.viewModelController?.paymentData.bankId = bank.id
        Router.pushPaymentDueViewController(viewModel: self.viewModelController, viewController: self, delegate: self.delegate)
        
    }
        
}

extension PaymentBankViewController: PaymentBankViewModelView {
    func showBanks(data: [PaymentBankModel]) {
        if data.count > 0 {
            self.banks = data
            self.tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Alerta", message: "No hay bancos disponibles para este metodo de pago. Intente con otro", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

