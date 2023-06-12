//
//  Login.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 29/01/23.
//

import SwiftUI

struct Login: View {
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    @EnvironmentObject private var viewModel: LoginViewModel
    
    
    private let colorTextoBlue = Color("textoBlue")
    
    var body: some View {
        ZStack {
            if viewModel.state == .loading {
                ProgressView()
            }
            
            if viewModel.state == .success {
                Perfil()
                    .environmentObject(viewModel)
            } else {
                
                VStack(spacing: 60) {
                    Text("LOGIN")
                        .foregroundColor(colorTextoBlue)
                        .font(.title)
                        .padding(.top,30)
                    
                    Image("loginImage")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 10)
                    
                    VStack(spacing: 30) {
                        TextField("Ingrese su usuario", text: $viewModel.email)
                            .padding()
                            .border(colorTextoBlue)
                        
                        TextField("Ingrese la contraseña", text: $viewModel.password)
                            .padding()
                            .border(colorTextoBlue)
                        
                    }
                    .padding(.horizontal,10)
                    
                    Text("Iniciar sesión") // Aca va el codigo para mostrar la vista de inicio de sesión
                        .padding()
                        .background(Color("buttonBlue"))
                        .foregroundColor(.black)
                        .cornerRadius(8.0)
                        .onTapGesture {
                            viewModel.login()
                        }
                    
                    Spacer()
                }
                .onAppear {
                    viewModel.validateSession()
                }
                .onReceive(viewModel.$state) {  state in
                    if case .failure(let error) = state {
                        showingAlert = true
                        errorMessage = error
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(errorMessage),
                          dismissButton: .default(Text(NSLocalizedString("ok", tableName: "Localizable", comment: ""))))
                }
                .padding()
            }
        }
        .background(Color("colorFondo").ignoresSafeArea(.all))
    }
}

struct Login_Previews: PreviewProvider {
    private static let apiService: APIServiceInterface = APIService()
    private static let loginViewModel: LoginViewModel = LoginViewModel(service: apiService)
    static var previews: some View {
        Login().environmentObject(loginViewModel)
    }
}
