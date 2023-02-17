//
//  File.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation

protocol CallerProtocol
{
    func makeRequest<T: Codable>(with parameters: APIQueryParameters, expecting: T.Type) async -> T?
}
