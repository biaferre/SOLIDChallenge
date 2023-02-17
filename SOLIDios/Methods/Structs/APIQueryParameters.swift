//
//  APIQueryParameters.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation
struct APIQueryParameters
{
    let path: String
    var queryItems: [URLQueryItem] = []
    let method: HTTPMethod
}
