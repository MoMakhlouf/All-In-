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
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
