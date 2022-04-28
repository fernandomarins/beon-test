//
//  APIService.swift
//  beon-project
//
//  Created by Fernando Marins on 28/04/22.
//

import Foundation

struct APIService {
    
    static let baseURL = "http://numbersapi.com/"
    
    static func downloadFact(factNumber: String, completion: @escaping (Result<Fact, Error>) -> Void ) {
        let fullUrl = APIService.baseURL + factNumber
        guard let url = URL(string: fullUrl) else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(Fact.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
