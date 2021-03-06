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
    @Published var flashCardCategory = FlashCardCategory()
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    /// Fetches all the flash cards in a category
    /// - Parameters:
    ///   - studentUID: UID of the student
    ///   - flashCardCategoryId: Flash card category ID where the flash cards need to be fetched from
    func fetchFlashCardsData(studentUID: String, flashCardCategoryId: String) {
        listener = db.collection("students").document(studentUID)
            .collection("flashCardCategories").document(flashCardCategoryId)
            .addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            do{
                self.flashCardCategory = try document.data(as: FlashCardCategory.self) ?? FlashCardCategory()
                self.flashCards = self.flashCardCategory.flashCards

            }catch{
                print(error)
                return
            }
        }
    }
    
    /// Detaches the listener for efficiency
    func detachFlashCardsDataListener() {
        if let listenerRegistration = listener {
            listenerRegistration.remove()
        }
    }
    
}
