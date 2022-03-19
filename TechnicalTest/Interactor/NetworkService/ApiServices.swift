//
//  ApiServices.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 17/03/22.
//

import Foundation
import Alamofire

protocol ApiServiceProtocol{
    typealias ItemDataCompletion = (DataModel?, Error?) -> Void
    typealias ItemTrailerCompletion = (DataTrailerModel?, Error?) -> Void
    typealias ItemReviewComplition = (ReviewDataModel?, Error?) -> Void
    typealias SearchMovieComplition = (SearchModel?, Error?) -> Void
}

class ApiServices: ApiServiceProtocol{
    
    static func getData(url: String,
                        completion: @escaping ItemDataCompletion,
                        failCompletion: @escaping (String) -> Void){
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF
            .request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DataModel.self, decoder: decoder) { response in
                switch response.result{
                case .success(let item):
                    DispatchQueue.main.async {
                        completion(item, nil)
                    }
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }
    }
    
    static func getTrailer(url: String,
                           completion: @escaping ItemTrailerCompletion,
                           failCompletion: @escaping (String) -> Void){
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF
            .request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DataTrailerModel.self, decoder: decoder) { response in
                switch response.result{
                case .success(let item):
                    DispatchQueue.main.async {
                        completion(item, nil)
                    }
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }
        
    }
    
    static func getReview(url: String,
                          completion: @escaping ItemReviewComplition,
                          failCompletion: @escaping (String) -> Void){
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF
            .request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ReviewDataModel.self, decoder: decoder) { response in
                switch response.result{
                case .success(let item):
                    DispatchQueue.main.async {
                        completion(item, nil)
                    }
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }
        
    }
    
    static func searchMovie(title: String, page: Int,
                            completion: @escaping ItemDataCompletion,
                            failCompletion: @escaping (String) -> Void){
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF
            .request("https://api.themoviedb.org/3/search/movie?api_key=d7ff494718186ed94ee75cf73c1a3214&language=en-US&query=\(title)&page=\(page)", method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DataModel.self, decoder: decoder) { response in
                switch response.result{
                case .success(let item):
                    DispatchQueue.main.async {
                        completion(item, nil)
                    }
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
            }
    }
}
