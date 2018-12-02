//
//  ServiceLocator.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation

protocol ServiceLocatorProtocol {
    
    func get<T>(service: T.Type) -> T?
}

final class ServiceLocator: ServiceLocatorProtocol {
    static let sharedInstance = ServiceLocator()
    
    func get<T>(service: T.Type) -> T? {
        
        switch String(describing: service) {
        case String(describing: CardsServiceProtocol.self):
            return CardsService() as? T
        default:
            return nil
        }
    }
}

