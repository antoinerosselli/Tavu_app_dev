//
//  String+Extensions.swift
//  TavuApp
//
//  Created by Florian Cartozo on 01/12/2022.
//

import Foundation

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}


struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

struct FailableCodableArray<Element : Codable> : Codable {

    var elements: [Element]

    init(from decoder: Decoder) throws {

        var container = try decoder.unkeyedContainer()

        var elements = [Element]()
        if let count = container.count {
            elements.reserveCapacity(count)
        }

        while !container.isAtEnd {
            if let element = try container
                .decode(FailableDecodable<Element>.self).base {

                elements.append(element)
            }
        }

        self.elements = elements
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(elements)
    }
}
