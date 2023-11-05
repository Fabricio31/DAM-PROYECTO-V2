//
//  LinkDataSource.swift
//  ProyectoV2
//
//  Created by BigSur on 4/11/23.
//
// []
// <>
//{}


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LinkModel: Decodable, Identifiable {
    @DocumentID var id: String?
    let url: String
    let title:	String
    let isFavorited: Bool
    let isCompleted: Bool
}

final class LinkDatasource{
    private let database = Firestore.firestore()
    private let collection = "links"
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        database.collection(collection)
            .addSnapshotListener{query, error in
                if let error = error {
                    print("Error obteniendo los links")
                    completionBlock(.failure(error))
                    return
                }
                //Si no hay un error
                guard let documents = query?.documents.compactMap({$0}) else {
                    completionBlock(.success([]))
                    return
                }
                let links = documents.map{ try? $0.data(as: LinkModel.self) }
                    .compactMap{$0}
                completionBlock(.success(links))
            }
   }

}

