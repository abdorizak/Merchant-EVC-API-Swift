//
//  ViewModel.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 7/15/22.
//

import UIKit


final class ViewModel {
    private var call = APICaller.shared
    var response: MerchantResponse?
    
    init () {
        
    }
    
    func makePayment(_ number: String, _ amount: Double) async throws {
        if #available(iOS 15, *) {
            do {
                self.response = try await call.makePayment(number: number, amount: amount)
                print("Response: \(String(describing: response))")
            } catch {
                throw MerchantErrors.unableTopComplete
            }
        } else {
            // will run Complition Function instead of Async
            call.makePayment(number: number, amount: amount) { result in
                switch result {
                case .success(let res):
                    self.response = res
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    
    func checkNumberCount(_ textField: UITextField, range: NSRange, string: String) -> Bool {
        let maxLength = 12
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
