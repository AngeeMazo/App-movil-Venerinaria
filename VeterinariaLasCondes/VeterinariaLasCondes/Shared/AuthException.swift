//
//  AuthException.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 30/05/23.
//

import Foundation

public enum AuthException: Error, LocalizedError, Equatable {
    case emailException
    case telefono
    
    public var errorDescription: String? {
        switch self {
        case .emailException:
            return "Email invalido"
        case .telefono:
            return "El telefono incorrecto"
        }
    }
    
}
