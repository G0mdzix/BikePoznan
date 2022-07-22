//
//  SearchValidatior.swift
//  BikePoznanTests
//
//  Created by Mateusz Gozdzik on 19/07/2022.
//

import XCTest
@testable import BikePoznan

class SearchValidatior: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func searchTest(){
        
        let test3 = Webservice()
        let test = StationGeometry(coordinates: [0.0,0.0])
        let test2 = StationDetails(label: "LasVegas", bikes: "100", free_racks: "-5")
     

}
