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
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    /// Fetches all the quiz card categories
    /// - Parameter studentUID: UID of the student
    func fetchData(studentUID: String) {
        listener = db.collection("students").document(studentUID).collection("flashCardCategories").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("There were no flash card categories")
                return
            }
            
            self.flashCardCategories = documents.compactMap{(queryDocumentSnapshot) -> FlashCardCategory? in
                return try? queryDocumentSnapshot.data(as: FlashCardCategory.self)
            }
        }
    }
    
    /// Detach the listener when you dont need real time updates
    func detachListenerForFlashCardCategories() {
        if let listenerRegistration = listener {
            listenerRegistration.remove()
        }
    }
}
 
