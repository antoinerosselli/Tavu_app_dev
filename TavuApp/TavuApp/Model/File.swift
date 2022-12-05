//
//  File.swift
//  TavuApp
//
//  Created by Florian Cartozo on 03/12/2022.
//

import Foundation

struct Group: Decodable, Hashable {
    var id: String
    var nbMember: Int
    var Member: String;
}
