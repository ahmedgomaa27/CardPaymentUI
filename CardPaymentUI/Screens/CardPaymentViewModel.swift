//
//  CardPaymentViewModel.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 14/06/2023.
//

import Foundation

class CardPaymentViewModel: ObservableObject {

    @Published var cardNameHolder: String = ""
    @Published var cardNumber: String = ""
    @Published var cardExpiryDate: String = ""
    @Published var cardCVV: String = ""
}
