//
//  FlashCards.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-09.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FlashCards: ObservableObject {
    @Published var flashCards = [FlashCardModel]()
    private var db = Firestore.firestore()
    
    func fetchFlashCardsData(studentUID: String, flashCardCategoryId: String) {
        db.collection("students").document(studentUID).collection("flashCardCategories").document(flashCardCategoryId).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            do{
                let flashCardCategory = try document.data(as: FlashCardCategory.self)
                self.flashCards = flashCardCategory?.flashCards ?? []

            }catch{
                print(error)
                return
            }
            
            
        }
            

    }
    
}
