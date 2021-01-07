//
//  Result.swift
//  MovieApiPractice2
//
//  Created by 황현지 on 2021/01/05.
//

import Foundation

struct Result {
    var adult : Bool = false
    var orglanguage : String = ""
    var orgtitle : String = ""
//    var popularity : Int = 0
}

//struct Result: Codable {
//    var adult : Bool = false
//    var orglanguage : String = ""
//    var orgtitle : String = ""
//
//    enum CodingKeys : String, CodingKey {
//        case adult
//        case orglanguage = "original_language"
//        case orgtitle = "original_title"
//    }
//
//    init(from decoder:Decoder) throws{
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        adult = try values.decode(Bool.self, forKey: .adult)
//        orglanguage = try values.decode(String.self, forKey: .orglanguage)
//        orgtitle = try values.decode(String.self, forKey: .orgtitle)
//    }
//}
//
//struct ResultDataStore: Codable {
//    var results: [Result]
//}
