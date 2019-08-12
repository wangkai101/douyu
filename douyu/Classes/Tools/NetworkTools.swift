//
//  NetworkTools.swift
//  Alamofire test
//
//  Created by Mr wngkai on 2019/5/16.
//  Copyright © 2019 Mr wngkai. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}



class NetworkTools {
    class func requestData(URL : String, type : MethodType, paramters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {
        
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(URL, method : method, parameters: paramters).responseJSON { (response) in
            //获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            //将结果会调回去
            finishedCallback(result)
        }
    }
}
