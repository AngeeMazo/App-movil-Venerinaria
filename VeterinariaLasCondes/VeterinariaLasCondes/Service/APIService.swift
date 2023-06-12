//
//  APIService.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 30/05/23.
//

import Foundation

protocol APIServiceInterface {
    func fetchData<T: Decodable>(from url: URL,
                                 email: String,
                                 password: String,
                                 completion: @escaping (Result<T, Error>) -> Void)
}

class APIService: APIServiceInterface {
    
    init() {}
    
    func fetchData<T: Decodable>(from url: URL,
                                 email: String,
                                 password: String,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "mail", value: email),
            URLQueryItem(name: "contrasena", value: password)
        ]
        
        guard let urlWithParams = components.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: urlWithParams) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            DispatchQueue.main.sync {
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(T.self, from: data)
                    
                    completion(.success(apiResponse))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
