//
//  SetPaymentCardViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Daniel Fernandez on 2/11/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class SetPaymentCardViewModelTests: XCTestCase {
    
    var sut: SetPaymentCardViewModel!
    var provider: MockUrlSessionProvider!
    
    override func tearDown() {
        sut = nil
        provider = nil
    }
    
    func testGetPaymentMethodsWithSuccess() {
        let method1 = PaymentMethod.with(id: "method1", status: "active")
        let method2 = PaymentMethod.with(id: "method2", status: "active")
        let payment = Payment.with(title: "payment1")
        provider = MockUrlSessionProvider(mode: .success([method1, method2]))
        sut = SetPaymentCardViewModel(sessionProvider: provider, payment: payment)
        sut.getPaymentMethods()
        XCTAssertEqual(sut.totalPaymentMethods, 2)
    }
    
    func testGetPaymentMethodsWithEmpty() {
        let emptyMode: MockUrlSessionProvider.Mode<Void> = .empty()
        let payment = Payment.with(title: "payment1")
        provider = MockUrlSessionProvider(mode: emptyMode)
        sut = SetPaymentCardViewModel(sessionProvider: provider, payment: payment)
        sut.getPaymentMethods()
        XCTAssertEqual(sut.totalPaymentMethods, 0)
    }
    
    func testGetPaymentMethodsWithError() {
        let failMode: MockUrlSessionProvider.Mode<Void> = .fail("Error")
        let payment = Payment.with(title: "payment1")
        provider = MockUrlSessionProvider(mode: failMode)
        sut = SetPaymentCardViewModel(sessionProvider: provider, payment: payment)
        
        sut.paymentMethodsDidFail = { message in
            XCTAssertEqual(message, "Error")
        }
        
        sut.getPaymentMethods()
    }
    
}
