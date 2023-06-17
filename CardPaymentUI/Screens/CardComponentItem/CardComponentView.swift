//
//  CardComponentView.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 16/06/2023.
//

import SwiftUI

struct CardComponentView: View {
    var title: String
    var placeholder: String
    var formatter: CardComponentFormatter?
    @StateObject var cardComponentItem: CardComponentItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            CardTextField(text: $cardComponentItem.value,
                            placeHolder: placeholder,
                          formatter: formatter)
            if let error = cardComponentItem.errorValue {
                Text(error)
                    .foregroundColor(.red)
            }
        }
    }
}

struct CardComponentItem_Previews: PreviewProvider {
    static var previews: some View {
        CardComponentView(title: "", placeholder: "", cardComponentItem: CardComponentItem())
    }
}
