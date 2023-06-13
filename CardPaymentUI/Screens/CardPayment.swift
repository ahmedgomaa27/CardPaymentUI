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
                                  text: $viewModel.cardNameHolder)
                
                CardComponentView(title: "Card Number",
                                  placeholder: "Enter your card number",
                                  text: $viewModel.cardNumber)
                
                HStack {
                    CardComponentView(title: "Expiry Date",
                                      placeholder: "MM/YY",
                                      text: $viewModel.cardExpiryDate)
                    CardComponentView(title: "CVV",
                                      placeholder: "Enter card CVV",
                                      text: $viewModel.cardCVV)
                }
                Spacer()
            }
            .padding(16)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardPayment(viewModel: CardPaymentViewModel())
    }
}

struct CardComponentView: View {
    var title: String
    var placeholder: String
    @Binding var text: String
//    @Binding var errorText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            CustomTextField(text: $text,
                            placeHolder: placeholder)
//            if !errorText.isEmpty {
//                Text(errorText)
//                    .foregroundColor(.red)
//            }
        }
    }
}
