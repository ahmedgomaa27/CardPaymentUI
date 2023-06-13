//
//  CustomTextField.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 13/06/2023.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    var placeHolder: String = ""
    
    var body: some View {
        ZStack {
            TextField(placeHolder, text: $text, prompt: Text(placeHolder).foregroundColor(.gray))
                .padding()
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""))
            .padding(16)
    }
}

