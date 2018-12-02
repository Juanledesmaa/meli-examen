//
//  DefaultRequest.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation

class DefaultRequest {

    let key = ServicePublicKey.key
    
    private struct Keys {
        static let public_key = "public_key"
    }
    
    func getParametersDictionary() -> [String: Any] {
        
        return [Keys.public_key: key]
    }
}
