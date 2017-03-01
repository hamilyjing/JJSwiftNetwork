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

class JJWeatherModel: JJSNetworkBaseObject, HandyJSON {
    
    var errNum: Int64?
    var errMsg: String?
    
    public override required init() {
        super.init()
    }
    
    open override func successForBussiness() -> Bool {
        return true
    }
    
    open override func stringForSave() -> String? {
        return self.toJSONString()
    }
}

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
        
        let network = JJSNetwork<JJWeatherModel>()
        network.hostURL = "https://apis.baidu.com/showapi_open_bus/weather_showapi/areaid"
        network.isSaveToDisk = true
        network.successCompletionBlock = { baseNetwork in
            print("123")
            let object = network.currentResponseObject()
            if let object1 = object as? JJWeatherModel {
                print(object1.errNum ?? Int64(0))
                print(object1.errMsg ?? "1234")
            }
            expectation.fulfill()
        }
        network.failureCompletionBlock = { baseNetwork in
            print("789")
            expectation.fulfill()
        }
        network.start()
        
        waitForExpectations(timeout: timeout)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
