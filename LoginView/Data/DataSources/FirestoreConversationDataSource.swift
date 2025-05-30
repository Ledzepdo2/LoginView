//
//  FirestoreConversationDataSource.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import FirebaseFirestore
import Combine

protocol ConversationDataSource {
    func fetchConversations(userId: String, completion: @escaping (Result<[ConversationDTO], Error>) -> Void)
}

final class FirestoreConversationDataSource: ConversationDataSource {
    private let database = Firestore.firestore()
    
    func fetchConversations(userId: String, completion: @escaping (Result<[ConversationDTO], Error>) -> Void) {
        database.collection("conversations")
            .whereField("participantIds", arrayContains: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let conversations = documents.compactMap { document -> ConversationDTO? in
                    try? document.data(as: ConversationDTO.self)
                }
                completion(.success(conversations))
            }
    }
}
