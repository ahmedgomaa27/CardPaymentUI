//
//  MockedCardPaymentService.swift
//  CardPaymentTests
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import Combine
@testable import CardPaymentUI
import Foundation

class MockedCardPaymentService: CardPaymentServiceProtocol {
    var resultType: Constants.MessageType = .success

    func startPayment(model: PaymentModel) -> AnyPublisher<PaymentResponseModel, Constants.AppErrors> {
        return Future<CardPaymentUI.PaymentResponseModel, Constants.AppErrors> { promise in
            switch self.resultType {
            case .success:
                promise(.success(PaymentResponseModel(token: UUID().uuidString,
                                                      paymentStatus: .authorized)))
            case .error:
                promise(.failure(.invalidPayment))
            }
                }
                .eraseToAnyPublisher()
    }
    
}
