//
//  NetworkManager.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 30.01.2022.
//

import Foundation
import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

final class NetworkManager {
    typealias result<T> = (Result<T, Error>) -> Void

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

}
