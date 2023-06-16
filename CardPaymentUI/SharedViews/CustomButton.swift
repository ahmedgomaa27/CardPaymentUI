//
//  CustomButton.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 16/06/2023.
//

import SwiftUI

struct CustomButton: View {
    var title: String = ""
    @Binding var showLoading: Bool
    @Binding var isActive: Bool
    
    var action: () -> ()
    private let height: CGFloat = 56
    var body: some View {
        Button(action: action) {
            ZStack {
                Text(showLoading ? "":title)
                    .frame(maxWidth: .infinity, minHeight: height)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                if showLoading {
                    LoadingIndicatorView(size: height/2)
                }
            }
            .disabled(!isActive)
            .opacity(isActive ? 1: 0.5)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(showLoading: .constant(false), isActive: .constant(false), action: {})
    }
}
