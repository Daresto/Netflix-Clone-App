//
//  Title.swift
//  Netflix Clone
//
//  Created by  Abdurahmon on 22/09/22.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let name: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let vote_average: Double
    let vote_count: Int
    let release_date: String?
}
