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
    @Published var disabled: Bool
    
    init(value: String = "", errorValue: String? = nil, disabled: Bool = false) {
        self.value = value
        self.errorValue = errorValue
        self.disabled = disabled
    }
}
