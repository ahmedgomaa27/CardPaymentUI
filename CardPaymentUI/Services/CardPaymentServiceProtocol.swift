//
//  CardPaymentServiceProtocol.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import Combine

protocol CardPaymentServiceProtocol {
    func startPayment(model: PaymentModel) -> AnyPublisher<PaymentResponseModel, Constants.AppErrors>
}
