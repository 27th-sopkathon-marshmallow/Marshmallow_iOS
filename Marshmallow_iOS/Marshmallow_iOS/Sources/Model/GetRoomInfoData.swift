//
//  GetRoomInfoData.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import Foundation
struct GetRoomInfoData: Codable {
    let title, startTime, limitTime: String
    let participant: [Participant]

    enum CodingKeys: String, CodingKey {
        case title, startTime, limitTime
        case participant = "Participant"
    }
}

