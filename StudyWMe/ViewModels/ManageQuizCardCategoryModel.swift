//
//  AddQuizCardCategoryModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ManageQuizCardCategoryModel: ObservableObject {
    private let quizCardCategoryTitleLimit = 30
    @Published var quizCardCategory: QuizCardCategory = QuizCardCategory(id: UUID().uuidString, title: "", image: "", quizCards: [QuizCardModel]()) {
        didSet{
            if quizCardCategory.title.count > quizCardCategoryTitleLimit {
                quizCardCategory.title = String(quizCardCategory.title.prefix(quizCardCategoryTitleLimit))
            }
        }
    }
    private var db = Firestore.firestore()
    

    
    /// Saves the given quiz card category in quiz card categories
    /// - Parameters:
    ///   - quizCardCategory: quiz card category that is to be saved
    ///   - studentUID: UID of the student
    ///   - handler: handler to handle the throw back event
    func saveQuizCategory(quizCardCategory: QuizCardCategory, studentUID: String, handler: @escaping ((Error?) -> Void)) {
//        print("UUID: \(String(describing: quizCardCategory.id))")
//        print("Title: \(quizCardCategory.title)")
//        print("Image: \(quizCardCategory.image)")
//        print("Number of quiz cards: \(quizCardCategory.quizCards.count)")
        
        do {
            let _ = try db.collection("students").document(studentUID)
                .collection("quizCardCategories")
                .document(quizCardCategory.id!)
                .setData(from: quizCardCategory, completion: handler)
        }catch{
            print(error)
        }
    }
    
    /// Saves the given set of quiz cards to quiz card category
    /// - Parameters:
    ///   - quizCardCategoryID: quiz card category ID where the quiz cards are to be saved
    ///   - quizCards: quiz cards that is to be saved
    ///   - studentUID: UID of the student
    ///   - handler: handler to handle the throwback event
    func saveQuizCardInExistingCategory(quizCardCategoryID: String, quizCards: [QuizCardModel], studentUID: String, handler: @escaping ((Error?) -> Void)) {
        
        db.collection("students").document(studentUID)
            .collection("quizCardCategories").document(quizCardCategoryID)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    do{
                        var quizCardCategory = try document.data(as: QuizCardCategory.self)
                        //Add the new Cards
                        quizCardCategory!.quizCards.append(contentsOf: quizCards)
                        //Save the category with newly added cards
                        self.saveQuizCategory(quizCardCategory: quizCardCategory!, studentUID: studentUID, handler: handler)
                    }catch{
                        print(error)
                    }
                    
                }else{
                    print("Document does not exist")
                }
            }

    }
    
    /// Delete the quiz card category that has the given quiz card category ID
    /// - Parameters:
    ///   - quizCardCategoryID: quiz card category ID
    ///   - studentUID: UID of the student
    ///   - handler: handler that handles the throw back event
    func deleteQuizCardCategory(quizCardCategoryID: String, studentUID: String, handler: @escaping ((Error?) -> Void)) {
        db.collection("students").document(studentUID)
            .collection("quizCardCategories").document(quizCardCategoryID)
            .delete(completion: handler)
    }
}
