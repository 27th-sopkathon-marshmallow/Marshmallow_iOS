//
//  NetworkResults.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import Foundation
enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
