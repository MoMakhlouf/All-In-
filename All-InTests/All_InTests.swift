//
//  All_InTests.swift
//  All-InTests
//
//  Created by Mohamed Makhlouf Ahmed on 29/06/2022.
//

import XCTest
@testable import All_In

class All_InTests: XCTestCase {
    
    var network : NetworkManagerMock!

    override func setUpWithError() throws {
     network = NetworkManagerMock(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
      network = nil
    }

    
    func testFetchingCodes(){
        network.fetchCodes { discountCodes, error in
           // print(discountCodes?.count)
            XCTAssertEqual(discountCodes?.count ?? 0, 2)
        }
    }
    
    
    
    
    
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
