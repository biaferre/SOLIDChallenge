//
//  AuthManager.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation
class AuthManager: AuthRequester
// funcoes daqui criam extensoes pra classe APICaller = open for extensions (O/C)
{
    // singleton exemplo
    
    static let shared = AuthManager()
    let apiCaller = APICaller() // note que nao usamos o dependency inversion pq cm eh um singleton nao tem problema ele """depender"""de api caller ja q so existe um dele
    
    private init() {} // garante q so pode instanciar dentro de si mesma
    
    private struct Constants
    {
        static let EMAIL = "email"
        static let PASSWORD = "password"
        static let AUTH_ROUTE = "/auth"
    }
    
    func requestAuth(userInput: UserInput) async -> AuthResponse?
    {
        
        let userInfo = [URLQueryItem(name: Constants.EMAIL, value: userInput.username),
                        URLQueryItem(name: Constants.PASSWORD, value: userInput.password)
                    ]
        
        let parameters = APIQueryParameters(path: Constants.AUTH_ROUTE, queryItems: userInfo, method: .POST)
        let response = await apiCaller.makeRequest(with: parameters, expecting: AuthResponse.self)
        return response
        
    }
    
}
