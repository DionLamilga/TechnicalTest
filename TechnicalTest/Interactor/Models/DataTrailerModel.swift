//
//  DataTrailerModel.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 18/03/22.
//

import Foundation

struct DataTrailerModel: Codable{
    let results: [VideoInfo]?
}

struct VideoInfo: Codable{
    let key: String?
    let type: String?
}
