//
//  QuizCardCategories.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-07.
//

import Foundation
import FirebaseFirestore

class QuizCardCategories: ObservableObject {
    @Published var quizCardCategories: [QuizCardCategory] = [QuizCardCategory]()
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    
    /// Fetches all the quiz card categories
    /// - Parameter studentUID: UID of the student
    func fetchData(studentUID: String) {
        listener = db.collection("students").document(studentUID).collection("quizCardCategories").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("There were no quiz card categories")
                return
            }
  
            self.quizCardCategories = documents.compactMap{(queryDocumentSnapshot) -> QuizCardCategory? in
                return try? queryDocumentSnapshot.data(as: QuizCardCategory.self)
            }
        }
    }
    
    /// Detach the listener when you dont need real time updates
    func detachListenerForQuizCardCategories() {
        if let listenerRegistration = listener {
            listenerRegistration.remove()
        }
    }

}
