//
//  PaymentsViewModelTests.swift
//  MercadoLibreTestTests
//
//  Created by Daniel Fernandez on 2/11/19.
//  Copyright © 2019 ronteq. All rights reserved.
//

import XCTest
@testable import MercadoLibreTest

class PaymentsViewModelTests: XCTestCase {
    
    var sut: PaymentsViewModel!
    var repoFilled: MockPaymentRepository!
    var repoEmpty: MockPaymentRepository!
    var repoError: MockPaymentRepository!
    
    override func tearDown() {
        sut = nil
        repoFilled = nil
        repoEmpty = nil
        repoError = nil
    }
    
    override func setUp() {
        repoFilled = MockPaymentRepository(mode: .fill)
        repoEmpty = MockPaymentRepository(mode: .empty)
        repoError = MockPaymentRepository(mode: .error)
    }
    
    func testPaymentsWithSuccess() {
        sut = PaymentsViewModel(paymentRepository: repoFilled)
        sut.getPayments()
        XCTAssertEqual(sut.totalPayments, 3)
    }
    
    func testEmptyPayments() {
        sut = PaymentsViewModel(paymentRepository: repoEmpty)
        sut.getPayments()
        XCTAssertEqual(sut.totalPayments, 0)
    }
    
    func testPaymentTitle() {
        sut = PaymentsViewModel(paymentRepository: repoFilled)
        sut.getPayments()
        let cellViewModel = sut.cellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cellViewModel.title, "payment1")
    }
    
}
