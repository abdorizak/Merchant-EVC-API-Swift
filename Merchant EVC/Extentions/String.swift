//
//  String.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 7/15/22.
//

import Foundation


extension String {
    func genrateReferenceID() -> String  {
        let random = UUID().uuidString
        let splited = random.components(separatedBy: "-")
        for string in splited {
            return string
        }
        return "123"
    }
    
    func genrateInvoiceID() -> String  {
        let random = UUID().uuidString
        let splited = random.components(separatedBy: "-")
        for string in splited {
            return string
        }
        return "123"
    }
}
