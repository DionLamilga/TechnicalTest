//
//  DataModel.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 17/03/22.
//

import Foundation

struct DataModel: Codable{
    let page: Int?
    let results: [listFilm]?
    let totalPages: Int?
}

struct listFilm: Codable{
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let voteAverage: Float?
    let voteCount: Int?
    let popularity: Float?
}
