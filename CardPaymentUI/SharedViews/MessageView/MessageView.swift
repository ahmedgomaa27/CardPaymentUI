//
//  MessageView.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import SwiftUI

struct MessageView: View {
    var text: String
    var backgroundColor: Color = .green
    
    var body: some View {
        VStack {
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding()
                .background(backgroundColor)
                .cornerRadius(10)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .transition(.move(edge: .top))
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(text: "")
    }
}
