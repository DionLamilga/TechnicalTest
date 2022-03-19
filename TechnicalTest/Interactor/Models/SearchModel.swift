//
//  SearchModel.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 19/03/22.
//

import Foundation

struct SearchModel: Codable{
    let result: [ListMovie]?
}

struct ListMovie: Codable{
    let id: Int?
}
