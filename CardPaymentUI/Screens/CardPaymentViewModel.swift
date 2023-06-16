//
//  CardPaymentViewModel.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 14/06/2023.
//

import Foundation
import Combine

class CardPaymentViewModel: ObservableObject {

    let cardNameHolder: CardComponentItem = CardComponentItem()
    let cardNumber: CardComponentItem = CardComponentItem()
    let cardExpiryDate: CardComponentItem = CardComponentItem()
    let cardCVV: CardComponentItem = CardComponentItem()
    @Published var isSubmitActive: Bool = false
    @Published var showLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindActions()
    }
    
    func bindActions() {
        cardNameHolder.$value.sink { newValue in
            self.validateCardHolderName(text: newValue)
        }
        .store(in: &cancellables)
        
        cardNumber.$value.sink { newValue in
            self.validateCardNumber(text: newValue)
        }
        .store(in: &cancellables)
        
        cardExpiryDate.$value.sink { newValue in
            self.validateExpiryDate(text: newValue)
        }
        .store(in: &cancellables)
        
        cardCVV.$value.sink { newValue in
            self.validateCvv(text: newValue)
        }
        .store(in: &cancellables)
    }
    
    private func validateCardHolderName(text: String) {
        //to pervent initial state error handling
        if text.isValidCardName || text.isEmpty {
            cardNameHolder.errorValue = nil
        } else {
            cardNameHolder.errorValue = "Invalid Name: should be more than 2 words"
        }
        checkSubmission()
    }
    
    private func validateCardNumber(text: String) {
        //to pervent initial state error handling
        if isValidCardNumber(text: text) || text.isEmpty {
            cardNumber.errorValue = nil
        } else {
            cardNumber.errorValue = "Invalid Card Number"
        }
        checkSubmission()
    }
    
    private func isValidCardNumber(text: String) -> Bool {
        //remove all spaces from text
        let numberText = text.filter({$0 != " "})
        print(numberText)
        return numberText.isValidVisaCardNumber() || numberText.isValidMastercardCardNumber()
    }
    
    private func validateExpiryDate(text: String) {
        //to pervent initial state error handling
        if text.isExpiryDateValid() || text.isEmpty  {
            cardExpiryDate.errorValue = nil
        } else {
            cardExpiryDate.errorValue = "Invalid Date"
        }
        checkSubmission()
    }
    
    private func validateCvv(text: String) {
        //to pervent initial state error handling
        if text.isCVVValid() || text.isEmpty  {
            cardCVV.errorValue = nil
        } else {
            cardCVV.errorValue = "Invalid CVV"
        }
        checkSubmission()
    }
    
    private func checkSubmission() {
        isSubmitActive = cardNameHolder.value.isValidCardName &&
        isValidCardNumber(text: cardNumber.value) &&
        cardExpiryDate.value.isExpiryDateValid() &&
        cardCVV.value.isCVVValid()
    }
}
