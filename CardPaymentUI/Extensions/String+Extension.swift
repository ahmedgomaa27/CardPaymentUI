//
//  String+Extension.swift
//  CardPaymentUI
//
//  Created by Ahmed Hamdy on 15/06/2023.
//

import Foundation

extension String {
    
    var isValidCardName: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ").count > 1
    }
    
    func isValidVisaCardNumber() -> Bool {
        // Visa card number validation logic
        let visaRegex = "^4[0-9]{12}(?:[0-9]{3})?$"
        let visaPredicate = NSPredicate(format: "SELF MATCHES %@", visaRegex)
        return visaPredicate.evaluate(with: self)
    }
    
    func isValidMastercardCardNumber() -> Bool {
        // Mastercard card number validation logic
        let mastercardRegex = "^5[1-5][0-9]{14}$"
        let mastercardPredicate = NSPredicate(format: "SELF MATCHES %@", mastercardRegex)
        return mastercardPredicate.evaluate(with: self)
    }
    
    func isExpiryDateValid() -> Bool {
        
        let currentDate = Date()
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthFormatter.locale = Locale(identifier: "en")
        let currentMonth = Int(monthFormatter.string(from: currentDate))
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yy"
        yearFormatter.locale = Locale(identifier: "en")
        let currentYear = Int(yearFormatter.string(from: currentDate))
        
        let expiryDatesplitted = self.split(separator: "/")
        
        if let expiryDateMonth = Int(expiryDatesplitted.first?.lowercased() ?? ""),
           let expiryDateYear = Int(expiryDatesplitted.last?.lowercased() ?? ""),
           let currentMonth = Int(monthFormatter.string(from: currentDate)),
           let currentYear = Int(yearFormatter.string(from: currentDate)) {
            return expiryDateYear > currentYear || (expiryDateMonth >= currentMonth && expiryDateYear == currentYear)
        }
        return false
    }
    
    func isCVVValid() -> Bool {
        // CVV should consist of 3 or 4 digits
        let cvvRegex = "^[0-9]{3,4}$"
        let cvvPredicate = NSPredicate(format: "SELF MATCHES %@", cvvRegex)
        return cvvPredicate.evaluate(with: self)
    }
}
