//
//  Perfil.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 29/01/23.
//

import SwiftUI

struct Perfil: View {
    @State var emailReserva: String = ""
    private let maxWidth: CGFloat = 300
    private let colorTextoBlue = Color("textoBlue")
    
    @EnvironmentObject private var viewModel: LoginViewModel
    
    func showDataView(title: String, data: String) -> some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(title)
                .foregroundColor(.gray)
            Text(data)
                .frame(maxWidth: maxWidth)
                .padding()
                .border(colorTextoBlue)
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack (spacing: 25) {
                
                Text("Información Reserva")
                    .foregroundColor(colorTextoBlue)
                    .font(.title)
                    .padding(.top,30)
                
                TextField("Ingrese email de la reserva" , text: $emailReserva)
                    .padding()
                    .border(colorTextoBlue)
                
                Button("Buscar Reserva") {
                    print("Buscando Reserva")
                        
                }
                .padding()
                .background(Color("buttonBlue"))
                .foregroundColor(.black)
                .cornerRadius(8)
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    showDataView(title: "Especialidad", data: "Especialidad")
                    
                    showDataView(title: "Especialista", data: "Especialista")
                    
                    showDataView(title: "Nombre y Apellido",
                                 data: "\(viewModel.register.first?.nombre ?? "") \(viewModel.register.first?.apellido ?? "")")
                    
                    showDataView(title: "Fecha", data: "Fecha")
                    
                    showDataView(title: "Hora", data: "hora")
                }
                .padding(.horizontal, 0)
                
                Button {
                    viewModel.closeSession()
                } label: {
                    Text("Cerrar Sesión")
                }
                .padding()
                .background(colorTextoBlue)
                .foregroundColor(.white)
                .cornerRadius(8)

            }
            .padding(.horizontal, 20)
        }
        .background(Color("colorFondo").ignoresSafeArea(.all))
    }
}

struct Perfil_Previews: PreviewProvider {
    static var previews: some View {
        Perfil()
    }
}

