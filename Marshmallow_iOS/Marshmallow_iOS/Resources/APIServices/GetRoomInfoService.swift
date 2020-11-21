//
//  GetRoomInfoService.swift
//  Marshmallow_iOS
//
//  Created by Yunjae Kim on 2020/11/22.
//

import Foundation

import Alamofire



struct GetRoomInfoService {
    static let shared = GetRoomInfoService()
   
    
    func getRoomInfo(id : Int, completion : @escaping (NetworkResult<Any>) -> Void) {
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        let dataRequest = AF.request(APIConstants.roomInfoURL+String(id),
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        
        dataRequest.responseData { response in
            switch response.result {
            case .success :
                print("======================1=======================")
                print(APIConstants.roomInfoURL+String(id))
                guard let statusCode = response.response?.statusCode else{
                    return
                }
                guard let data = response.value else{
                    return
                    
                }
                
               
                completion(judgeRoomInfo(statusCode: statusCode, data : data))
                
            case .failure :
                print("======================2=======================")
                completion(.networkFail)
                
                
            }
            
            
        }
        
        
        
    }
    
    
    
    func judgeRoomInfo(statusCode : Int , data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<GetRoomInfoData>.self, from : data) else{
         
           
            return .pathErr
            
        }
        
        switch statusCode{
        case 200:
            print(data)
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


