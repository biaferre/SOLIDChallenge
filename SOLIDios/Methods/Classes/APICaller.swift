//
//  APICaller.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation
class APICaller: CallerProtocol
// so faz request: closed for modifications (O/C)
{
    
    private struct Constants
    {
        static let API_URL = "http://localhost:3001"
    }
    
    func makeRequest<T: Codable>(with parameters: APIQueryParameters, expecting: T.Type) async -> T? // aplicacao de generics -> T
    // reduzir numero de argumentos facilita os testes :)
    {
        guard var urlComponents = URLComponents(string: Constants.API_URL) else {return nil}
        urlComponents.path = parameters.path
        urlComponents.queryItems = parameters.queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = parameters.method.rawValue
        request.httpBody = urlComponents.query?.data(using: .utf8)

        let session = URLSession.shared

        do {
            let (data, _) = try await session.data(for: request)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let requestResponse = try decoder.decode(expecting, from: data)
            return requestResponse
            
        } catch {
            print("Erro \(error)")
        }
        
        return nil
    }
}
