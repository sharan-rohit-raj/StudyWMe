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
    @Published var quizCardCategory = QuizCardCategory()
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func fetchQuizCardsData(studentUID: String, quizCardCatId: String) {
        listener = db.collection("students").document(studentUID).collection("quizCardCategories").document(quizCardCatId).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
              print("Error fetching document: \(error!)")
              return
            }
            do{
                self.quizCardCategory = try document.data(as: QuizCardCategory.self) ?? QuizCardCategory()
                self.quizCards = self.quizCardCategory.quizCards

            }catch{
                print(error)
                return
            }
            
            
        }
    }
    
    func detachQuizCardsDataListener() {
        if let listenerRegistration = listener {
            listenerRegistration.remove()
        }
    }
}
