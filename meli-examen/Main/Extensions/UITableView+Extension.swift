//
//  UITableView+Extension.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import UIKit
extension UITableViewCell {
    
    static var identifier: String {
        let name = String(describing: self)
        return name
    }
    
    static var nib: UINib {
        let nib = UINib(nibName: self.identifier, bundle: Bundle(for: self))
        return nib
    }
}
