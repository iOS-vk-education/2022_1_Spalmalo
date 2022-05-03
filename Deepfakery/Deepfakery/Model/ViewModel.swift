//
//  ViewModel.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 28.04.2022.
//

import Foundation

struct ResponseResult: Decodable {
    let type: String
    let score: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.score = try container.decode(String.self, forKey: .score)
    }
    
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case score
    }
}

struct DecodableType: Decodable {
    let result: ResponseResult
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode(ResponseResult.self, forKey: .result)
    }
    
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case result
    }
}

struct Document {
    let uuid: String
    let url: String
    let type: String
}

