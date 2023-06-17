//
//  PaymentResponseModel.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import Foundation


struct PaymentResponseModel: Codable {
    let token: String?
    let paymentStatus: Constants.PaymentStatus
}
