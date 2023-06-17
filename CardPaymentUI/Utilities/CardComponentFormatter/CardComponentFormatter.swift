//
//  CardComponentFormatter.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 15/06/2023.
//

import UIKit.UIKeyboardLayoutGuide

protocol CardComponentFormatter {
    func format(text: String) -> String
    func setKeyboardType() -> UIKeyboardType
}


class CardNumberFormatter: CardComponentFormatter {
    func setKeyboardType() -> UIKeyboardType {
        .asciiCapableNumberPad
    }
    

    func format(text: String) -> String {
        let cleanNumber = text.replacingOccurrences(of: " ", with: "")
        let maxLength = 16
        
        var formattedNumber = ""
        for (index, character) in cleanNumber.enumerated() {
            if index != 0 && index % 4 == 0 {
                formattedNumber.append(" ")
            }
            if index >= maxLength {
                        break
                    }
            formattedNumber.append(character)
        }
        
        return formattedNumber
    }
}


class ExpiryDateFormatter: CardComponentFormatter {
    func setKeyboardType() -> UIKeyboardType {
        .asciiCapableNumberPad
    }
    

    func format(text: String) -> String {
        let cleanDate = text.replacingOccurrences(of: "/", with: "")
        
        var formattedDate = ""
        for (index, character) in cleanDate.enumerated() {
            if index == 2 {
                formattedDate.append("/")
            }
            if index >= 4 {
                break
            }
            formattedDate.append(character)
        }
        return formattedDate
    }
}



class CVVFormatter: CardComponentFormatter {
    func setKeyboardType() -> UIKeyboardType {
        .asciiCapableNumberPad
    }
    

    func format(text: String) -> String {
        var formattedNumber = ""
        for (index, character) in text.enumerated() {
            if index >= 4 {
                break
            }
            formattedNumber.append(character)
        }
        return formattedNumber
    }
}
