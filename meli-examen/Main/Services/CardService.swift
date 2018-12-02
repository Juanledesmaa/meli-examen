//
//  CardService.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//

import Foundation
import Alamofire

private enum EndPointsCard: String {
    case PaymentMethod = "payment_methods"
    case PaymentBank = "payment_methods/card_issuers"
    case PaymentInstallment = "payment_methods/installments"
}

protocol CardsServiceProtocol: Service {

    func getCardData(completion: @escaping ([PaymentModel]?, Error?) -> Void)
    func getBankData(method: String, completion: @escaping ([PaymentBankModel]?, Error?) -> Void)
    func getInstallments(request: TestModel, completion: @escaping ([PaymentDueModel]?, Error?) -> Void)
}

final class CardsService: CardsServiceProtocol {
    func getInstallments(request: TestModel, completion: @escaping ([PaymentDueModel]?, Error?) -> Void) {

        NetworkManager.manager.request(ServiceBaseUrl.baseUrl + EndPointsCard.PaymentInstallment.rawValue, method: .get, parameters: ["public_key" : ServicePublicKey.key, "payment_method_id" : request.cardId ?? "", "issuer.id": request.bankId ?? "", "amount": request.amount ?? 0.0]).responseJSON { response in
            
            if response.response?.statusCode == StatusCodes.ok {
                
                switch response.result {
                    
                case .success:

                    do {
                        guard let json = response.result.value as? [[String: Any]] else { return completion(nil, nil) }
                        let data = jsonToNSData(json: json[0]["payer_costs"] as AnyObject)
                        let installments = try JSONDecoder().decode([PaymentDueModel].self, from: data! as Data)
                        completion(installments, nil)
                        
                    } catch let parseError as NSError {
                        print("JSON Error \(parseError.localizedDescription)")
                    }
                    
                    break
                    
                case .failure(let error):
                    completion(nil, error)
                    break
                }
                
            } else {
                completion(nil, response.result.error)
            }
        }
    }
    
    
    func getBankData(method: String, completion: @escaping ([PaymentBankModel]?, Error?) -> Void) {
        NetworkManager.manager.request(ServiceBaseUrl.baseUrl + EndPointsCard.PaymentBank.rawValue, method: .get, parameters: ["public_key" : ServicePublicKey.key, "payment_method_id" : method]).responseJSON { response in
            
            if response.response?.statusCode == StatusCodes.ok {
                
                switch response.result {
                    
                case .success:
                    do {
                        let banks = try JSONDecoder().decode([PaymentBankModel].self, from: response.data ?? Data())
                        completion(banks, nil)
                        
                    } catch let parseError as NSError {
                        print("JSON Error \(parseError.localizedDescription)")
                    }
                    
                    break
                    
                case .failure(let error):
                    completion(nil, error)
                    break
                }
                
            } else {
                completion(nil, response.result.error)
            }
        }
    }

    func getCardData(completion: @escaping ([PaymentModel]?, Error?) -> Void) {

        NetworkManager.manager.request(ServiceBaseUrl.baseUrl + EndPointsCard.PaymentMethod.rawValue, method: .get, parameters: ["public_key" : ServicePublicKey.key]).responseJSON { response in
            
            if response.response?.statusCode == StatusCodes.ok {
                
                switch response.result {
                    
                case .success:
                    do {
                        let payments = try JSONDecoder().decode([PaymentModel].self, from: response.data ?? Data())
                        completion(payments, nil)
                        
                    } catch let parseError as NSError {
                        print("JSON Error \(parseError.localizedDescription)")
                    }
                    
                    break
                    
                case .failure(let error):
                    completion(nil, error)
                    break
                }

            } else {
                completion(nil, response.result.error)
            }
        }
    }
    
}
