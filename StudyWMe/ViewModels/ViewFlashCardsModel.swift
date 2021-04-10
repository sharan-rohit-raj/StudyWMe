//
//  ViewFlashCardsModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-09.
//

import Foundation
import FirebaseFirestore

class ViewFlashCardsModel: ObservableObject {
    @Published var flashCards: [FlashCardModel] = [FlashCardModel]()
    
//    [FlashCardModel(id: UUID().uuidString, title: "What is my name?", details: "Sharan"),
//       FlashCardModel(id: UUID().uuidString, title: "What do I Study?", details: "Computer Science"),
//       FlashCardModel(id: UUID().uuidString, title: "Where do I live?", details: "Waterloo"),
//       FlashCardModel(id: UUID().uuidString, title: "What is my profession?", details: "Developer")]
    
    private var db = Firestore.firestore()
    
    func fetchData(studentUID: String, flashCardCategoryId: String) {
        db.collection("students").document(studentUID)
            .collection("flashCardCategories").document(flashCardCategoryId)
            .collection("flashCards").addSnapshotListener {(querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("There were no flash cards")
                    return
                }
                
                //Map each flash card document to a flash card model and add it to the
                //flash card models array
                self.flashCards = documents.map{(queryDocumentSnapshot) -> FlashCardModel in
                    let data = queryDocumentSnapshot.data()
                    
                    let id: String = data["id"] as? String ?? ""
                    let title: String = data["title"] as? String ?? ""
                    let details: String = data["details"] as? String ?? ""
                    
                    let flashCard = FlashCardModel(id: id, title: title, details: details)
                    return flashCard
                }
            }
    }
}
