//
//  PaymentModel.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation

struct PaymentModel: Decodable {
    let id: String
    let name: String
    let payment_type_id: String
    let status: String
    let secure_thumbnail: String
    let thumbnail: String

}
