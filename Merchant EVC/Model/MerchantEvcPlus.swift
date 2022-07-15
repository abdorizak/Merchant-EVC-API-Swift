//
//  APICaller.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 6/19/22.
//

import Foundation

// MARK: - Welcome
struct MerchantEvcPlus: Codable {
    var schemaVersion: String = "1.0"
    let requestId = UUID()
    let timestamp = String(Int64(Date().timeIntervalSince1970 * 1000))
    var channelName: String = "WEB"
    let serviceName: String = "API_PURCHASE"
    let serviceParams: ServiceParams
}

// MARK: - ServiceParams
struct ServiceParams: Codable {
    let merchantUid: String
    let apiUserId: String
    let apiKey: String
    let paymentMethod: String = "mwallet_account"
    let payerInfo: PayerInfo
    let transactionInfo: TransactionInfo
}

// MARK: - PayerInfo
struct PayerInfo: Codable {
    let accountNo: String
}

// MARK: - TransactionInfo
struct TransactionInfo: Codable {
    let referenceId: String?
    let invoiceId: String?
    let amount: Double
    let currency: String
    let description: String?
}


