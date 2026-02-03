//
//  AuthenticationService.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 11/01/25.
//

import Foundation
import Combine

final class AuthenticationService {
    static let shared = AuthenticationService()
    
    @Published var status: Status = .idle
    
    enum Status {
        case authenticated
        case unauthenticated
        case idle
        case onboarding
    }
}
