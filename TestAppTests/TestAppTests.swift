

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidateLocation(){
        let locationName = "Apple infinite loop"
        LocationManager().getGeoLocation(location: locationName, successHandler: { (result) -> Void in
            XCTAssert(result)
        }, failureHandler: {(error) -> Void in
            XCTFail()
        })
    }
    
    func testOpenWikiApp(){
        let urlScheme =  "ShowLocationThroughDeepLinking://host/"
        let lat = "37.332082387122"
       let long = "-122.030764055579"
       if let custURL : URL = LocationViewController().getURL(urlScheme: urlScheme, latitude: lat, longitude: long){
            if UIApplication.shared.canOpenURL(custURL){
                XCTAssert(true)
            }else{
                XCTFail()
            }
       }else{
            XCTFail()
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
