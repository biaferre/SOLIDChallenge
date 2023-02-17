//
//  File.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation

protocol AuthRequester
{
    
    func requestAuth(userInput: UserInput) async -> AuthResponse?
    
}
