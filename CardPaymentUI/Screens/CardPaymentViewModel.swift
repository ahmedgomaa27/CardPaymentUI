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
    let amount: Double

    @Published var isSubmitActive: Bool = false
    @Published var showLoading: Bool = false

    @Published var isMessagePresented: Bool = false
    @Published var messageType: Constants.MessageType = .success
    @Published var messageText: String = ""
    
    var response: PaymentResponseModel?
    
    private var cancellables = Set<AnyCancellable>()
    private let service: CardPaymentServiceProtocol
    private var paymentCancellable: AnyCancellable?
    
    
    init(service: CardPaymentServiceProtocol = CardPaymentService(), amount: Double) {
        self.service = service
        self.amount = amount
        bindActions()
    }
    
    func startPayment() {
        showLoading = true
        let dataModel = PaymentModel(cardNameHolder: cardNameHolder.value,
                                     cardNumber: cardNumber.value.replacingOccurrences(of: " ", with: ""),
                                     expiryDate: cardExpiryDate.value,
                                     cvv: cardCVV.value,
                                     amount: amount)
        
        paymentCancellable = service.startPayment(model: dataModel)
            .sink { completion in
                self.showLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    //show Error
                    self.showMessage(type: .error, error: error)
                }
            } receiveValue: { paymentResponse in
                self.showLoading = false
                self.response = paymentResponse
                //show success
                //if we need to save the reponse, token will be saved in KeyChain to make sure it saved in a secured way
                self.showMessage(type: .success)
            }

    }
    
    private func bindActions() {
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
    
    private func showMessage(type: Constants.MessageType, error: Constants.AppErrors? = nil) {
        self.messageType = type
        self.isMessagePresented = true
        switch type {
        case .success:
            self.messageText = "Payment Done Succesfully"
        case .error:
            self.messageText = error?.message ?? Constants.AppErrors.genericError.message
        }
    }
}
