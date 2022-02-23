//
//  Answer.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import Foundation

struct Answer: Codable {
    var magic: Magic

    enum CodingKeys: String, CodingKey {
           case magic = "magic"
    }
}

struct Magic: Codable {
    let question: String
    let answer: String
    let type: String

    enum CodingKeys: String, CodingKey {
      case answer = "answer"
      case type = "type"
      case question = "question"
    }
}

class TableAnswers {
    static let tableObj = TableAnswers()
    private init() { }

    var arrayAnswers: [String] = []
    static var countAnswers: Int = 0
}
