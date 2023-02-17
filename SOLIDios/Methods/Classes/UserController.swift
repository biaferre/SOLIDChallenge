//
//  UserController.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation
class UserController: UserRequester
{
    static let shared = UserController()
    private init() {}

    let apiCaller = APICaller()
    
    private struct Constants
    {
        static let LOGIN_ROUTE = "/login"
    }

    func getAllUsers() async -> UserResponse? {
        let parameters = APIQueryParameters(path: Constants.LOGIN_ROUTE, method: .GET)
        let response = await apiCaller.makeRequest(with: parameters, expecting: UserResponse.self)
        return response
    }
}
