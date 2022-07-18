//
//  NetworkManagerTests.swift
//  All-InTests
//
//  Created by Marwa on 18/07/2022.
//

import XCTest
@testable import All_In

class NetworkManagerTests: XCTestCase {
    var apiService: ApiServices!
    
    
    override func setUp() {
        //apiService = NetworkManager()
        apiService = NetworkManagerMock(shouldReturnError: false)
    }
    override func tearDown() {
        apiService = nil
    }
    func testFetchBrands(){
        apiService.fetchBrands { smartCollections, error in
            XCTAssertEqual(smartCollections?.smart_collections.count ?? 0, 2)
        }
        
    
        
    }
    
    func testFetchProducts(){
        apiService.fetchProducts { products, error in
            XCTAssertEqual(products?.products.count ?? 0, 1)
        }
        
    }
    
    func testFetchCollections(){
        apiService.fetchCategories { collections, error in
            XCTAssertEqual(collections?.custom_collections.count ?? 0, 3)
        }
        
    }
    
    func testOrderCollections(){
        apiService.getOrder(customerID: 6280692859094) { orders, error in
            XCTAssertEqual(orders?.orders.count ?? 0, 1)
        }
    }
    
    
    
    
    
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
