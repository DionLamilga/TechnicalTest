//
//  ReviewDataModel.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 18/03/22.
//

import Foundation

struct ReviewDataModel: Codable{
    let results: [ListReview]?
}

struct ListReview: Codable{
    let author: String?
    let content: String?
}
