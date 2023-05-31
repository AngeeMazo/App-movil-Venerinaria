//
//  LoginViewModel.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 30/05/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    // let es una constante en Swift
    // var es una variable en Swift
    
    @Published var email = "" //almacenar el valor que ingresa el usuario en el login
    @Published var password = "" // Almacena la contraseña
    @Published var state = ViewModelState.initial
    
    private let errorPassword: String = "Usuario o contraseña incorrecta"
    private let urlLogin: URL = URL(string: "hht")!
    private let service: APIServiceInterface
    
    init(service: APIServiceInterface) {
        self.service = service
    }
    
    func login() {
        state = .loading
        do {
            try validateEmail(email: email)
            service.fetchData(from: urlLogin, email: email, password: password) { [weak self] (result: Result<Bool, Error>) in
                switch result {
                case .success(let data):
                    self?.userDefault(successLogin: data)
                    self?.state = .success
                case .failure(_):
                    self?.state = .failure(error: self?.errorPassword ?? "")
                }
            }
        } catch {
            self.state = .failure(error: error.localizedDescription)
        }
        
    }
    
    func validateSession() {
        let isLogin = UserDefaults.standard.bool(forKey: "login")
        if isLogin {
            state = .success
        } else {
            state = .initial
        }
    }
    
    
    func closeSession() {
        userDefault(successLogin: false)
        state = .initial
    }
    
    private func validateEmail(email: String) throws {
        let emailRegEx = #"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$"#
        if try !NSRegularExpression(pattern: emailRegEx).matches(email) {
            throw AuthException.emailException
        }
    }
    
    //Guardar en UserDefault especie de base de datos
    private func userDefault(successLogin: Bool) {
        //Nunca guardar datos sencibles aca
        UserDefaults.standard.set(successLogin, forKey: "login")
        UserDefaults.standard.synchronize()
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

