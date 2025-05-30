//
//  LoginViewTests.swift
//  LoginViewTests
//
//  Created by Jesus Perez on 30/05/25.
//

import Testing
import XCTest
@testable import LoginView

// Mock para simular AuthRepositoryProtocol
class MockAuthRepository: AuthRepositoryProtocol {
    private let shouldSucceed: Bool
    init(shouldSucceed: Bool) { self.shouldSucceed = shouldSucceed }
    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if shouldSucceed {
            completion(.success(()))
        } else {
            completion(.failure(NSError(domain: "AuthError", code: 1, userInfo: nil)))
        }
    }
}

func testLogin_withValidCredentials_completesSuccessfully() throws {
    let mockAuth = MockAuthRepository(shouldSucceed: true)
    let useCase = LoginUseCase(authRepository: mockAuth)
    let expectation = XCTestExpectation(description: "Login should succeed")

    useCase.execute(username: "user", password: "pass") { result in
        switch result {
        case .success:
            expectation.fulfill()
        case .failure(let error):
            XCTFail("Expected success, but got error: \(error)")
        }
    }

    wait
}

func testLogin_withInvalidCredentials_fails() throws {
    let mockAuth = MockAuthRepository(shouldSucceed: false)
    let useCase = LoginUseCase(authRepository: mockAuth)
    let expectation = XCTestExpectation(description: "Login should fail")

    useCase.execute(username: "user", password: "wrong") { result in
        switch result {
        case .success:
            XCTFail("Expected failure, but got success")
        case .failure:
            expectation.fulfill()
        }
    }

    wait
}
