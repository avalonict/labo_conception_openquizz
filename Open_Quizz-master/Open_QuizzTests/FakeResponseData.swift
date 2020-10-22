//
//  FakeResponseData.swift
//  Open_QuizzTests
//
//  Created by Gabriel Larue on 2020-08-24.
//  Copyright © 2020 Gabriel Larue. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassroom.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassroom.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let imageData = "image".data(using: .utf8)!
    
    static let questionData = "question".data(using: .utf8)!
    
    class ResponseError: Error {}
    static let error = ResponseError()
}

