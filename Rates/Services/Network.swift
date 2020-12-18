//
//  Network.swift
//  Rates
//
//  Created by Александр on 15.12.2020.
//

import Foundation
import UIKit

enum NewResult<Value>{
    case success(Value)
    case failure(Error)
}

func fetchData(value: String,completion: ((NewResult<RatesModel>) -> Void)?){
    
    let url = URL(string: "https://api.exchangeratesapi.io/latest?base=\(value)")
    
    let request = URLRequest(url: url!)
    let session = URLSession.shared
    
    let task = session.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let address = try decoder.decode(RatesModel.self, from: jsonData)
                    completion?(.success(address))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }
    task.resume()
}
