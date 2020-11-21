//
//  MakeRoomService.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import Foundation
import Alamofire

struct MakeRoomService {
    
    static let shared = MakeRoomService()
    
    func makeRoom(title : String, limitTime : String, startTime : String, completion : @escaping (NetworkResult<Any>) -> (Void)) {
        let url = APIConstants.makeRoomURL
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        let body : Parameters = [
            "title" : title,
            "limitTime": limitTime,
            "startTime" : startTime
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData{ response in
            switch response.result {
            case .success :
                
                guard let statusCode = response.response?.statusCode else{
                    return
                }
                guard let data = response.value else{
                    return
                    
                }
                
                completion(judgeRoom(status: statusCode, data: data))
                
                
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
                
            }
            
            
        }
        
        
    }
    
    
    
    private func judgeRoom(status : Int, data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MakeRoomData>.self, from : data) else{
            
            
            return .pathErr
            
        }
       
        switch status{
        case 200:
            return .success(decodedData.data)
        case 400..<500 :
            return .requestErr(decodedData.message)
        case 500 :
            return .serverErr
            
        default :
            return .networkFail
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
