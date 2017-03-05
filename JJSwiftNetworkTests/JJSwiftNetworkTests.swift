//
//  JJSwiftNetworkTests.swift
//  JJSwiftNetworkTests
//
//  Created by JJ on 2/17/17.
//  Copyright © 2017 jianjing. All rights reserved.
//

import XCTest

import HandyJSON

@testable import JJSwiftNetwork

class JJSwiftNetworkTests: XCTestCase {
    
    let timeout: TimeInterval = 30.0
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = self.expectation(description: "myExpectation")
        
        JJSWeatherService().requestWeather { (result, otherInfo) in
            if result.isSuccess {
                let object = result.value as! JJSWeatherModel
                print(object)
            } else {
                let error = result.error!
                print(error)
            }
            
            expectation.fulfill()
        }
        
//        let weatherNetwork = JJSWeatherNetwork(parameters: nil, identity: "getWeather", isSaveToMemory: false, isSaveToDisk: true, jsonConvert: JJSNetworkJsonConvert<JJWeatherModel>())
//        weatherNetwork.successCompletionBlock = { baseNetwork in
//            print("success")
//            let object = weatherNetwork.currentResponseObject()
//            if let object1 = object as? JJWeatherModel {
//                print(object1.errNum ?? Int64(0))
//                print(object1.errMsg ?? "1234")
//            }
//            expectation.fulfill()
//        }
//        weatherNetwork.failureCompletionBlock = { baseNetwork in
//            print("fail")
//            expectation.fulfill()
//        }
//        weatherNetwork.start()
        
        waitForExpectations(timeout: timeout)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
