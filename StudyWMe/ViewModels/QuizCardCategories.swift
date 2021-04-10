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
    
//    [QuizCardCategory(id: UUID().uuidString, title: "CP264", image: "moonBuilding"),
//     QuizCardCategory(id: UUID().uuidString, title: "CP216", image: "tallBuilding"),
//     QuizCardCategory(id: UUID().uuidString, title: "CP214", image: "torontoBuilding"),
//     QuizCardCategory(id: UUID().uuidString, title: "CP164", image: "foggyBuilding")]
    
    private var db = Firestore.firestore()
    
    func fetchData(studentUID: String) {
        db.collection("students").document(studentUID).collection("quizCardCategories").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("There were no quiz card categories")
                return
            }
  
            self.quizCardCategories = documents.compactMap{(queryDocumentSnapshot) -> QuizCardCategory? in
                return try? queryDocumentSnapshot.data(as: QuizCardCategory.self)
            }
        }
    }

}
