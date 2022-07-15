//
//  MarchantError.swift
//  Merchant EVC
//
//  Created by Abdirizak Hassan on 7/15/22.
//

import Foundation

enum MerchantErrors: String, Error {
    case invalidURL = "HEYYY!!! Give me a valid URL"
    case invalidUsernameOrPassword = "this username created an invalid request. please try again.."
    case invalidCredentials = "please check that you have used the correct email and password"
    case unableTopComplete = "Unable to complete you request. Please check your Internet connection.."
    case inValidResponse = "Invalid response from the server. please try again."
    case inValidData = "the data recevied from the server was Invalid. please try again."
    case decodingError = "Response could not be decoded"
}
