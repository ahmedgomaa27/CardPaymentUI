//
//  CardPaymentTests.swift
//  CardPaymentTests
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import XCTest
@testable import CardPaymentUI

final class CardPaymentTests: XCTestCase {
    
    var viewModel: CardPaymentViewModel!
    let mockedService = MockedCardPaymentService()

    override func setUp() {
        super.setUp()
        viewModel = CardPaymentViewModel(service: mockedService, amount: 10)
    }
    
    func testBindActions_CardNameHolder() {
        viewModel.cardNameHolder.value = "Ahmed"
        //make sure card name error has a value
        XCTAssertNotNil(viewModel.cardNameHolder.errorValue)
    }
    
    func testBindActions_CardNumber() {
        viewModel.cardNumber.value = "4444455"
        //make sure card number error has a value
        XCTAssertNotNil(viewModel.cardNumber.errorValue)
    }
    
    func testBindActions_ExpiryDate() {
        viewModel.cardExpiryDate.value = "01"
        //make sure card expiry date error has a value
        XCTAssertNotNil(viewModel.cardExpiryDate.errorValue)
    }
    
    func testBindActions_CardCVV() {
        viewModel.cardCVV.value = "12"
        //make sure card name error has a value
        XCTAssertNotNil(viewModel.cardCVV.errorValue)
    }
    
    func testPayment_Success() {
        mockedService.resultType = .success
        viewModel.startPayment()
        XCTAssertNotNil(viewModel.response?.token)
        
    }
    
    func testPayment_SuccessMessage() {
        mockedService.resultType = .success
        viewModel.startPayment()
        XCTAssertEqual(viewModel.messageType, Constants.MessageType.success)
        
    }
    
    func testPayment_Failure() {
        mockedService.resultType = .error
        viewModel.startPayment()
        XCTAssertNil(viewModel.response)
        
    }
    
    func testPayment_FailureMessage() {
        mockedService.resultType = .error
        viewModel.startPayment()
        XCTAssertEqual(viewModel.messageType, Constants.MessageType.error)
        
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

}
