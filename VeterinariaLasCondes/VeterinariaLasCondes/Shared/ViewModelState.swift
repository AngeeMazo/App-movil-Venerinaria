//
//  ViewModelState.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 30/05/23.
//

import Foundation

enum ViewModelState: Equatable {
    case initial
    case loading
    case success
    case failure(error: String)
}
