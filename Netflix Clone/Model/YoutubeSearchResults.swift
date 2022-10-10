//
//  YoutubeSearchResults.swift
//  Netflix Clone
//
//  Created by  Abdurahmon on 30/09/22.
//

import Foundation

struct YoutubeSearchResults: Codable {
    let items: [VideoElements]
}

struct VideoElements: Codable {
    let id: IDVideoElement
}

struct IDVideoElement: Codable {
    let kind: String
    let videoId: String
}
 
