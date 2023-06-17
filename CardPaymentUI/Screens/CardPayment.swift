//
//  ContentView.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 13/06/2023.
//

import SwiftUI

struct CardPayment: View {

    @StateObject var viewModel: CardPaymentViewModel

    var body: some View {
        VStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                Text("Enter Payment Info")
                    .font(.title2)
                    .foregroundColor(.white)
                    .bold()
            }
            .frame(height: 50)
            
            VStack(spacing: 24) {
                CardComponentView(title: "Name On Card",
                                  placeholder: "Enter the name of the card",
                                  cardComponentItem: viewModel.cardNameHolder)
                
                CardComponentView(title: "Card Number",
                                  placeholder: "Enter your card number",
                                  formatter: CardNumberFormatter(),
                                  cardComponentItem: viewModel.cardNumber)
                
                HStack(alignment: .top) {
                    CardComponentView(title: "Expiry Date",
                                      placeholder: "MM/YY",
                                      formatter: ExpiryDateFormatter(),
                                      cardComponentItem: viewModel.cardExpiryDate)
                    CardComponentView(title: "CVV",
                                      placeholder: "Enter card CVV",
                                      formatter: CVVFormatter(),
                                      cardComponentItem: viewModel.cardCVV)
                }
                Spacer()
                CustomButton(title: "Submit",
                             showLoading: $viewModel.showLoading,
                             isActive: $viewModel.isSubmitActive) {
                    viewModel.startPayment()
                }

            }
            .padding(16)
            
        }
        .modifier(MessageViewModifier(isPresented: $viewModel.isMessagePresented,
                                      type: $viewModel.messageType,
                                      text: viewModel.messageText))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardPayment(viewModel: CardPaymentViewModel(amount: 10))
    }
}
