//
//  User.swift
//  SOLIDvai
//
//  Created by Bof on 14/02/23.
//

import Foundation


struct UserInput
{
    // diferencas entre struct e classe:
    // struct -> estrutura de dados que guarda valores brutos
    // classe -> struct que tem uma referencia
    
    var username: String?
    var password: String?
}

struct AuthResponse: Codable
{
    var data: APIData?
}

struct UserResponse: Codable
{
    var data: [User]
}


struct APIData: Codable {
    let user: User
    let token: String
}

struct User: Codable
{
    var id: String?
    var email: String?
    var username: String?
    var name: String?

}

protocol AuthRequester
{
    
    func requestAuth(userInput: UserInput) async -> AuthResponse?
    
}

protocol UserRequester
{
    func getAllUsers() async -> UserResponse?
}

class AuthManager: AuthRequester, UserRequester
{
    // singleton exemplo
    
    static let shared = AuthManager()
    let apiCaller = APICaller()
    
    private init() {} // garante q so pode instanciar dentro de si mesma
    
    func getAllUsers() async -> UserResponse? {
    
        
        let parameters = APIQueryParameters(path: "/login", method: "GET")
        let response = await apiCaller.makeRequest(with: parameters, expecting: UserResponse.self)
        return response
    }
    
    func requestAuth(userInput: UserInput) async -> AuthResponse? {
        
        let userInfo = [
                        URLQueryItem(name: "email", value: userInput.username),
                        URLQueryItem(name: "password", value: userInput.password)
                    ]
        
        let parameters = APIQueryParameters(path: "/auth", queryItems: userInfo, method: "POST")
        let response = await apiCaller.makeRequest(with: parameters, expecting: AuthResponse.self)
        return response
    }
    
}

struct APIQueryParameters {
    let path: String
    var queryItems: [URLQueryItem] = []
    let method: String
}

class APICaller
{
    func makeRequest<T: Codable>(with parameters: APIQueryParameters, expecting: T.Type) async -> T? // aplicacao de generics
    // reduzir numero de argumentos facilita os testes :)
    {
        guard var urlComponents = URLComponents(string: "http://localhost:3001") else {return nil}
        urlComponents.path = parameters.path
        urlComponents.queryItems = parameters.queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = parameters.method
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
