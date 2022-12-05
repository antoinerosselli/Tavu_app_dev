//
//  Video.swift
//  TavuApp
//
//  Created by Florian Cartozo on 01/12/2022.
//

import Foundation

struct Video: Decodable, Hashable {
    var title: String
    var channelName: String
    var miniature: String;
}


struct VideoResponse: Decodable {
    var list: [Video]
}
