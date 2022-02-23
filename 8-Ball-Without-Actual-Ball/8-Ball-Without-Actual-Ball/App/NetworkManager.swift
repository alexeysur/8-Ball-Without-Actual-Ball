//
//  NetworkManager.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 30.01.2022.
//

import Foundation
import UIKit
import Alamofire

enum DataError: Error {
    case invalidResponse
    case decodingError
}

class NetworkManager {
    typealias result<T> = (Swift.Result<T, Error>) -> Void
    private let alamofireManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    
    func getAnswer<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping result<T>) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }

            if 200...299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let decodedData = try decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(DataError.decodingError))
                    }
                }
            }
        }.resume()
    }

   func getAnswerUseAlamofire<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping result<T>) {
       let encoding: ParameterEncoding = JSONEncoding.default
       
       let _ = alamofireManager.request(url, method: .get,
                                              parameters: nil, encoding: encoding,
                                              headers: nil).responseJSON { response in
           if response.result.isSuccess {
               if let decodedData = response.result.value as? T {
                   completion(.success(decodedData))
               } else {
                   completion(.failure(DataError.decodingError))
               }
           } else {
               completion(.failure(DataError.invalidResponse))
           }
       }
  }
    
}
