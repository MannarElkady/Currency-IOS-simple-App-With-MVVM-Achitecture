//
//  NetworkService.swift
//  SportyNews
//
//  Created by Manar on 4/18/20.
//  Copyright © 2020 ITI. All rights reserved.

import Foundation
import CodableAlamofire
import Alamofire
class NetworkService{
 
    func getResponseData <T: Decodable> (SuccessHandler onSuccess: @escaping (T) -> (), ErrorHandler onError: @escaping () -> ()) {
        if(!NetworkService.isConnectedToInternet){
            print(Constant.ERROR_NO_CONNECTION.rawValue)
            return
        }
        AF.request(URL(string: Constant.BASE_URL.rawValue)!).responseDecodableObject(completionHandler: {
            (dataResponse : AFDataResponse<T>) in
            switch dataResponse.result {
            case .success(let value):
                print(value)
                onSuccess(value)
            case .failure(let error):
                print(error)
                print(Constant.PARSING_ERROR.rawValue)
            }})
    }
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
