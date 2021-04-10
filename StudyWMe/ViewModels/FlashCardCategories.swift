//
//  FlashCardCategories.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-07.
//

import Foundation
import FirebaseFirestore

class FlashCardCategories: ObservableObject {
    @Published var flashCardCategories: [FlashCardCategory] =  [FlashCardCategory]()
    
    //[FlashCardCategory(id: UUID().uuidString, title: "CP373", image: "forestFlashCard"),
//    FlashCardCategory(id: UUID().uuidString, title: "CP372",image: "moonFlashCard"),
//    FlashCardCategory(id: UUID().uuidString, title: "CP351", image: "orangeTreeFlashCard"),
//    FlashCardCategory(id: UUID().uuidString, title: "CP363", image: "raysFlashCard"),
//    FlashCardCategory(id: UUID().uuidString, title: "CP3863", image: "sunsetFlashCard")]
    private var db = Firestore.firestore()

    func fetchData(studentUID: String) {
        db.collection("students").document(studentUID).collection("flashCardCategories").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("There were no flash card categories")
                return
            }
            
            self.flashCardCategories = documents.compactMap{(queryDocumentSnapshot) -> FlashCardCategory? in
                return try? queryDocumentSnapshot.data(as: FlashCardCategory.self)
            }
        }
    }
}
 
