//
//  PaymentMethodViewController.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentMethodViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var cards = [PaymentModel]()
    var viewModel: PaymentMethodViewModelDelegate?
    var viewModelController: PaymentModelViewController?
    var delegate: PaymentReceivedProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forma de pago"
        self.setupTableView()
        self.viewModel?.getPaymentMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.clearTableViewOnAppearance()
    }
    
    private func clearTableViewOnAppearance() {
        for indexPath in tableView.indexPathsForSelectedRows ?? [] {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupTableView() {
        self.tableView.register(methodTableViewCell.nib, forCellReuseIdentifier: methodTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension PaymentMethodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: methodTableViewCell.identifier) as? methodTableViewCell else {
            return methodTableViewCell()
        }
        
        let payment = self.cards[indexPath.row]
        let url = URL(string: payment.secure_thumbnail)
        cell.imgMethod.kf.setImage(with: url)
        cell.lblMethod.text = payment.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payment = self.cards[indexPath.row]
        self.viewModelController?.paymentData.creditCardName = payment.name
        self.viewModelController?.paymentData.creditCardUrl = payment.secure_thumbnail
        self.viewModelController?.paymentData.cardId = payment.id

        Router.pushPaymentBankViewController(viewModel: self.viewModelController, viewController: self, delegate: delegate)
    }
    
}

extension PaymentMethodViewController: PaymentMethodViewModelView {
    func showPaymentMethods(data: [PaymentModel]) {
        self.cards = data
        self.tableView.reloadData()
    }
}

