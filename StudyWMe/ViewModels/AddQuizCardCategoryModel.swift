//
//  AddQuizCardCategoryModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AddQuizCardCategoryModel: ObservableObject {
    
    @Published var quizCardCategory: QuizCardCategory = QuizCardCategory(id: UUID().uuidString, title: "", image: "", quizCards: [QuizCardModel]())
    private var db = Firestore.firestore()
    

    
    func saveQuizCategory(quizCardCategory: QuizCardCategory, studentUID: String, handler: @escaping ((Error?) -> Void)) {
        print("UUID: \(String(describing: quizCardCategory.id))")
        print("Title: \(quizCardCategory.title)")
        print("Image: \(quizCardCategory.image)")
        print("Number of quiz cards: \(quizCardCategory.quizCards.count)")
        

//        let data: [String: Any] = [ "UUID": quizCardCategory.id!,
//                    "Title": quizCardCategory.title,
//                    "Image": randomImages.randomElement()!]
        
        do {
            let _ = try db.collection("students").document(studentUID)
                .collection("quizCardCategories")
                .document(quizCardCategory.id!)
                .setData(from: quizCardCategory, completion: handler)
        }catch{
            print(error)
        }

        
//        quizCardCategory.quizCards.forEach { quizCard in
//            let quizCardData: [String: Any] = [
//                "id": quizCard.id!,
//                "question": quizCard.question,
//                "correctOption": quizCard.correctOption,
//                "options": quizCard.options
//                ]
//
//            //Get the document ID to store all the options after storing the question card
//            db.collection("students").document(studentUID)
//                .collection("quizCardCategories")
//                .document(quizCardCategory.id!)
//                .collection("quizCards")
//                .document(quizCard.id!)
//                .setData(quizCardData)
            
            //Save all the options for the quiz Card
            
//            //Store all the options for the question
//            quizCard.options.forEach { optionValue in
//                let optionData: [String: Any] = ["id" : optionValue.id, "option" : optionValue.option]
//
//                db.collection("students").document(studentUID)
//                    .collection("quizCardCategories")
//                    .document(quizCardCategory.id)
//                    .collection("quizCards")
//                    .document(quizCard.id)
//                    .collection("options")
//                    .document(String(optionValue.id))
//                    .setData(optionData)
//            }
//        }
    }
}
