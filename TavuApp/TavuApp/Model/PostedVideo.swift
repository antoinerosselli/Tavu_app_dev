//
//  PostedVideo.swift
//  TavuApp
//
//  Created by Florian Cartozo on 03/12/2022.
//

import Foundation

struct PostedVideo: Decodable, Hashable {
    var author: String
    var video: Video
    var date: Date;
    var group: Group
}
