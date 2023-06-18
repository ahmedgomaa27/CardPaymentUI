//
//  CardComponentItem.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 16/06/2023.
//

import Foundation

class CardComponentItem: ObservableObject {
    @Published var value: String
    @Published var errorValue: String?
    
    init(value: String = "", errorValue: String? = nil) {
        self.value = value
        self.errorValue = errorValue
    }
}
