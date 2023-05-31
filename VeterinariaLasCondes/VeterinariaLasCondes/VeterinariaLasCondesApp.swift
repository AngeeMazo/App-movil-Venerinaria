//
//  VeterinariaLasCondesApp.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 29/01/23.
//

import SwiftUI

@main //Inicia la appp
struct VeterinariaLasCondesApp: App {
    
    var body: some Scene {
        let apiService: APIServiceInterface = APIService()
        let loginViewModel: LoginViewModel = LoginViewModel(service: apiService)
        
        WindowGroup {
            Login() // llamamos la primer vista que queremos mostrar
                .environmentObject(loginViewModel)
        }
    }
}
