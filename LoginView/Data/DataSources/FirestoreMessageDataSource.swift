//
//  FirestoreMessageDataSource.swift
//  LoginView
//
//  Created by Jesus Perez on 30/05/25.
//

import FirebaseFirestore

protocol MessageDataSource {
    func fetchMessages(conversationId: String, completion: @escaping (Result<[MessageDTO], Error>) -> Void)
    func sendMessage(_ message: MessageDTO, completion: @escaping (Result<MessageDTO, Error>) -> Void)
    func subscribeToMessages(conversationId: String, listener: @escaping (Result<[MessageDTO], Error>) -> Void) -> ListenerRegistration
}

final class FirestoreMessageDataSource: MessageDataSource {
    private let store = Firestore.firestore()
    private var collection: CollectionReference { store.collection("messages") }

    func fetchMessages(conversationId: String, completion: @escaping (Result<[MessageDTO], Error>) -> Void) {
        collection
          .whereField("conversationId", isEqualTo: conversationId)
          .order(by: "sentAt", descending: false)
          .getDocuments { snap, error in
            if let error = error {
                completion(.failure(error)); return
            }
            do {
                let dtos = try snap?.documents.compactMap { try $0.data(as: MessageDTO.self) } ?? []
                completion(.success(dtos))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func sendMessage(_ message: MessageDTO, completion: @escaping (Result<MessageDTO, Error>) -> Void) {
        do {
            let docRef = try collection.addDocument(from: message)
            completion(.success(message))
        } catch {
            completion(.failure(error))
        }
    }

    func subscribeToMessages(conversationId: String, listener: @escaping (Result<[MessageDTO], Error>) -> Void) -> ListenerRegistration {
        return collection
          .whereField("conversationId", isEqualTo: conversationId)
          .order(by: "sentAt", descending: false)
          .addSnapshotListener { snap, error in
            if let error = error {
                listener(.failure(error)); return
            }
            do {
                let dtos = try snap?.documents.compactMap { try $0.data(as: MessageDTO.self) } ?? []
                listener(.success(dtos))
            } catch {
                listener(.failure(error))
            }
        }
    }
}
