//
//  MerchantResponse.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 6/24/22.
//

import Foundation

struct MerchantResponse: Decodable {
    let schemaVersion: String?
    let timestamp: String?
    let requestId: String?
    let responseCode: String?
    let errorCode: String?
    let responseMsg: String?
    let params: Params?
}

// MARK: - Params
struct Params: Decodable {
}
