//
//  User.swift
//  TavuApp
//
//  Created by Florian Cartozo on 03/12/2022.
//

import Foundation

struct User: Decodable, Hashable {
    var googleId: String
    var username: String
}
