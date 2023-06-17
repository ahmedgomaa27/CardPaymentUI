//
//  MessageViewModifier.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 17/06/2023.
//

import SwiftUI

struct MessageViewModifier: ViewModifier {

    @Binding var isPresented: Bool
    var type: Constants.MessageType = .success
    var text: String
    var duration: CGFloat = 2
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    MessageView(text: text, backgroundColor: getMessageColor())
                    Spacer()
                }
                .animation(.easeInOut(duration: 0.3))
                .transition(.move(edge: .top))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
    
    func getMessageColor() -> Color {
        switch type {
        case .success:
            return .green
        case .error:
            return .red
        }
    }
}
