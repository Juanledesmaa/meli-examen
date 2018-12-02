//
//  Service.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation
import Alamofire

enum ApiError: Error {
    case parsingError
    case dataError
    case serverError
}

protocol Service {
    var baseURL: String { get }
    var header: HTTPHeaders { get }
}

extension Service {
    var baseURL: String {
        return ServiceBaseUrl.baseUrl
    }
    
    var header: HTTPHeaders { return ["Content-Type": "application/json"] }
}
