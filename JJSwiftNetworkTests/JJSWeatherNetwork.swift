//
//  JJSWeatherNetwork.swift
//  JJSwiftNetwork
//
//  Created by JJ on 3/2/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import XCTest

@testable import JJSwiftNetwork

public class JJSWeatherNetwork: JJSNetworkRequest {
    
    public override func requestHostURL() -> String {
        return "https://apis.baidu.com"
    }
    
    public override func requestPathURL() -> String {
        return "/showapi_open_bus/weather_showapi/areaid"
    }
    
    public override func filterResponseString() -> String? {
        return "{\"result\":[{\"errNum\": 300202,\"errMsg\": \"Missing apikey\"},{\"errNum\": 300202,\"errMsg\": \"Missing apikey\"}]}"
    }
    
    public override func getConvertObjectContent(_ resoponseDic: Any) -> Any {
        switch resoponseDic {
        case let object as [String : Any] where object.count > 0:
            return object["result"] ?? resoponseDic
        default:
            return resoponseDic
        }
    }
}
