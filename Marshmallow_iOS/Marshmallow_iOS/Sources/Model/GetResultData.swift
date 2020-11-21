//
//  GetResultData.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import Foundation


struct GetResultData: Codable {
    let participant: [Participant]

    enum CodingKeys: String, CodingKey {
        case participant = "Participant"
    }
}

// MARK: - Participant
struct Participant: Codable {
    let nickname: String
    let percent: Int
}
