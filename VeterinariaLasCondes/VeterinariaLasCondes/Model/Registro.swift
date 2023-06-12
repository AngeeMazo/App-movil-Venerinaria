//
//  Registro.swift
//  VeterinariaLasCondes
//
//  Created by Angee Mazo on 12/06/23.
//

struct Registro: Codable {
    let idRegistro: Int?
    let mail: String
    let idMascota: String?
    let nombre: String
    let apellido: String
    let contrasena: String
    let telefono: String
    let administrador: Int

    enum CodingKeys: String, CodingKey {
        case idRegistro = "id_Registro"
        case mail
        case idMascota = "id_mascota"
        case nombre, apellido, contrasena, telefono, administrador
    }
}

