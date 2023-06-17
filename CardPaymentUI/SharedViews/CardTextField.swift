//
//  CustomTextField.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 13/06/2023.
//

import SwiftUI

struct CardTextField: View {
    
    @Binding var text: String
    var placeHolder: String = ""
    var formatter: CardComponentFormatter?
    
    var body: some View {
        ZStack {
            TextField(placeHolder, text: $text, prompt: Text(placeHolder).foregroundColor(.gray))
                .padding()
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .keyboardType(formatter?.setKeyboardType() ?? .default)
                .onChange(of: text) { newValue in
                    if let formatter = formatter {
                        text = formatter.format(text: newValue)
                    }
                }
            //we can use another way to handle it, by using focus state to check text field focus and when focus is false we send the binded value to card component item
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CardTextField(text: .constant(""))
            .padding(16)
    }
}
