//
//  APIResponse.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 30/05/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
}

struct APIResponse<T: Decodable>: Decodable {
    let data: T
}
