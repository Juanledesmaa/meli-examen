//
//  GenericAlert.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit

protocol GenericAlertDelegate {
    func didCloseGenericAlert()
}


class GenericAlert: UIViewController {

    @IBOutlet var lblCuota: UILabel!
    @IBOutlet var lblBank: UILabel!
    @IBOutlet var imgBank: UIImageView!
    @IBOutlet var lblPayMethod: UILabel!
    @IBOutlet var imgPayMethod: UIImageView!
    @IBOutlet var lblMonto: UILabel!
    @IBOutlet var alertHeightConstant: NSLayoutConstraint!
    var delegate: GenericAlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()

    }
    
    private func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished : Bool)  in
            if (finished) {
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }



    @IBAction func closeAlert(_ sender: CustomButton) {
        self.removeAnimate()
        if let _ = delegate {
            delegate?.didCloseGenericAlert()
        }
    }
    
}
