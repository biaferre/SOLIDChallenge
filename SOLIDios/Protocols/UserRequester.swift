//
//  File.swift
//  SOLIDios
//
//  Created by Bof on 16/02/23.
//

import Foundation

protocol UserRequester
{
    func getAllUsers() async -> UserResponse?
}
