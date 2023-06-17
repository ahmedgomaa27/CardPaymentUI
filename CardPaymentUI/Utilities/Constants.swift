//
//  Constants.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import Foundation

struct Constants {
    enum AppErrors: Error {
        case invalidPayment
        case genericError

        var message: String {
            switch self {
            case .invalidPayment:
                return "Invalid payment data"
            case .genericError:
                return "Something went wrong, Please try again"
            }
        }
    }
    
    enum PaymentStatus: String, Codable {
        case authorized
        case failure
    }
    
    enum MessageType {
        case success
        case error
    }
}
