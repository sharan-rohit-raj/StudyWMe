//
//  QuizCards.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-10.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuizCards: ObservableObject {
    @Published var quizCards = [QuizCardModel]()
    private var db = Firestore.firestore()
    
    func fetchQuizCardsData(studentUID: String, quizCardCatId: String) {
        db.collection("students").document(studentUID).collection("quizCardCategories").document(quizCardCatId).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            do{
                let quizCardCategory = try document.data(as: QuizCardCategory.self)
                self.quizCards = quizCardCategory?.quizCards ?? []

            }catch{
                print(error)
                return
            }
            
            
        }
    }
}
