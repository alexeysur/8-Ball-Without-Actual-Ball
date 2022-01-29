//
//  Answer.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import Foundation

struct Answer: Codable {
    let answer: String
    let type: String
    let date: Date

    init(answer: String, type: String, date: Date = Date()) {
        self.answer = answer
        self.type = type
        self.date = date
    }
}
