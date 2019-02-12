//
//  AmountViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Daniel Fernandez on 2/11/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class AmountViewModelTests: XCTestCase {
    
    var sut: AmountViewModel!
    
    override func tearDown() {
        sut = nil
    }
    
    override func setUp() {
        sut = AmountViewModel()
    }
    
    func testSetAmount() {
        sut.setAmount(to: 5)
        XCTAssertEqual(sut.amount, 5)
    }
    
}
