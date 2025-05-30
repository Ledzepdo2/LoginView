//
//  FirestoreUserRepository.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import Foundation

struct UserDTO: Codable {
    let id: String
    let name: String
    let email: String
}

extension UserDTO {
    func toDomain() -> User {
        User(id: id, name: name, email: email, avatarURL: nil)
    }
}

final class FirestoreUserRepository: UserRepositoryProtocol {
    
    private let dataSource: UserDataSource

    init(dataSource: UserDataSource = FirestoreUserDataSource()) {
        self.dataSource = dataSource
    }

    func fetchUser(id: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataSource.fetchUser(id: id) { result in
            switch result {
            case .success(let dto):
                let user = User(id: dto.id,
                                name: dto.name,
                                email: dto.email,
                                avatarURL: nil)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func updateUser(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let dto = UserDTO(id: user.id,
                          name: user.name,
                          email: user.email)
        dataSource.updateUser(dto, completion: completion)
    }

    func fetchUsers(userIds: [String], completion: @escaping (Result<[User], Error>) -> Void) {
        var users = [User]()
        let group = DispatchGroup()
        
        for userId in userIds {
            group.enter()
            dataSource.fetchUser(id: userId) { result in
                if case .success(let dto) = result {
                    users.append(dto.toDomain())
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(users))
        }
    }
}
