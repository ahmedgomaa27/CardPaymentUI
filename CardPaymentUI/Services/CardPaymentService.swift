//
//  CardPaymentService.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import Combine
import Foundation

class CardPaymentService: CardPaymentServiceProtocol {
    func startPayment(model: PaymentModel) -> AnyPublisher<PaymentResponseModel, Constants.AppErrors> {
        let _: [String: Any] = [
            "cardNameHolder": model.cardNameHolder,
            "cardNumber": model.cardNumber,
            "expiryDate": model.expiryDate,
            "cvv": model.cvv,
            "amount": model.amount
        ]
        
        return Future<PaymentResponseModel, Constants.AppErrors> { promise in
            // Perform API request here
            
            // Mocking response (success or failure)
            let success = Bool.random() // Simulate success or failure randomly
            
            if success {
                let responseModel = PaymentResponseModel(token: UUID().uuidString, paymentStatus: .authorized)
                promise(.success(responseModel))
            } else {
                promise(.failure(.invalidPayment))
            }
        }
        .delay(for: .seconds(1), scheduler: DispatchQueue.main) // Simulate delay
        .eraseToAnyPublisher()
    }
}
