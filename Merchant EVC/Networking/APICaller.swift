//
//  APICaller.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 6/19/22.
//

import UIKit

final class APICaller{
    
    static let shared = APICaller()
    private let ref = ""
    private let invoiceID = ""
    private init() { }
    
    
    @available(iOS 15.0, *)
    func makePayment(number: String, amount: Double) async throws -> MerchantResponse {
        
        guard let url = URL(string: Constants.endPoint) else {
            throw MerchantErrors.invalidURL
        }
        
        let body = MerchantEvcPlus(serviceParams: ServiceParams( merchantUid: "xxxxxxxx", apiUserId: "xxxxxxxx", apiKey: "xxxxxxxx", payerInfo: PayerInfo(accountNo: number), transactionInfo: TransactionInfo( referenceId: ref.genrateReferenceID(), invoiceId: invoiceID.genrateInvoiceID(), amount: amount, currency: "USD", description: "Test")))
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = try? JSONEncoder().encode(body)
        request.httpBody = encoder
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MerchantErrors.inValidResponse
        }
        
        do {
            return try JSONDecoder().decode(MerchantResponse.self, from: data)
        } catch {
            throw MerchantErrors.inValidData
        }
        
    }
    
    
    func makePayment(number: String, amount: Double, completion: @escaping (Result<MerchantResponse, MerchantErrors>) -> Void) {

        guard let url = URL(string: Constants.endPoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = MerchantEvcPlus(serviceParams: ServiceParams( merchantUid: "xxxxxxxx", apiUserId: "xxxxxxxx", apiKey: "xxxxxxxx", payerInfo: PayerInfo(accountNo: number), transactionInfo: TransactionInfo( referenceId: ref.genrateReferenceID(), invoiceId: invoiceID.genrateInvoiceID(), amount: amount, currency: "USD", description: "Test")))

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = try? JSONEncoder().encode(body)
        request.httpBody = encoder

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(.inValidData))
                return
            }

            do {
                let res = try JSONDecoder().decode(MerchantResponse.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
