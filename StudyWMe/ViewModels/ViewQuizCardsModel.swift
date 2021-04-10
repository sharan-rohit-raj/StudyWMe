//
//  ViewQuizCardsModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-09.
//

import Foundation
import FirebaseFirestore

class ViewQuizCardsModel: ObservableObject {
    @Published var quizCards: [QuizCardModel] = [QuizCardModel]()
    private var db = Firestore.firestore()
    
//    [
//        QuizCardModel(
//            id: UUID().uuidString,
//            question: "What is my name?",
//            options: [QuizOptionsModel(id: 0, option: "Sharan"),
//                      QuizOptionsModel(id: 1, option: "Rohit"),
//                      QuizOptionsModel(id: 2, option: "Raj"),
//                      QuizOptionsModel(id: 3, option: "All of the above")],
//            correctOption: 3),
//        QuizCardModel(
//            id: UUID().uuidString,
//            question: "What is my favourite colour?",
//            options: [QuizOptionsModel(id: 0, option: "Pink"),
//                       QuizOptionsModel(id: 1, option: "Red"),
//                       QuizOptionsModel(id: 2, option: "Yellow"),
//                       QuizOptionsModel(id: 3, option: "Purple")],
//            correctOption: 3),
//        QuizCardModel(
//            id: UUID().uuidString,
//            question: "What is my favourite movie?",
//            options: [QuizOptionsModel(id: 0, option: "Avengers"),
//                       QuizOptionsModel(id: 1, option: "Tenet"),
//                       QuizOptionsModel(id: 2, option: "Master"),
//                       QuizOptionsModel(id: 3, option: "ABC")],
//            correctOption: 2),
//        QuizCardModel(
//            id: UUID().uuidString,
//            question: "What do I live?",
//            options: [QuizOptionsModel(id: 0, option: "Waterloo"),
//                       QuizOptionsModel(id: 1, option: "Mississauga"),
//                       QuizOptionsModel(id: 2, option: "Toronto"),
//                       QuizOptionsModel(id: 3, option: "Scarborough")],
//            correctOption: 0),
//    ]
    
    func fetchData(studentUID: String, quizCardCategoryId: String) {
        db.collection("students").document(studentUID)
            .collection("quizCardCategories").document(quizCardCategoryId)
            .collection("quizCards").addSnapshotListener {(querSnapShot, error) in
                guard let documents = querSnapShot?.documents else {
                    print("There were no quiz cards")
                    return
                }
                
                //Map each quiz card document to a quiz card model and add it to the
                //quiz card models array
                self.quizCards = documents.map {(queryDocumentSnapShot)-> QuizCardModel in
                    let data = queryDocumentSnapShot.data()
                    
                    let id: String = data["id"] as? String ?? ""
                    let question: String = data["question"] as? String ?? ""
                    let correctOption: String = data["correctOption"] as? String ?? "0"
                    let options: [QuizOptionsModel] = data["options"] as? [QuizOptionsModel] ?? []
                    let quizCard: QuizCardModel = QuizCardModel(id: id, question: question, options: options, correctOption: correctOption)
                    
                    return quizCard
                }
                
            }
    }
    
    private func getOptions(studentUID: String, quizCardCategoryId: String, quizCardId: String)-> [QuizOptionsModel] {
        //Get all the options
        var options: [QuizOptionsModel] = [QuizOptionsModel]()
        
        self.db.collection("students").document(studentUID)
            .collection("quizCardCategories").document(quizCardCategoryId)
            .collection("quizCards").document(quizCardId).collection("options").addSnapshotListener {(querSnapShot, error) in
                guard let optionsDocuments = querSnapShot?.documents else {
                    print("There were no quiz cards")
                    return
                }
                
                    options = optionsDocuments.map {(queryOptionDocumentSnapShot)-> QuizOptionsModel in
                    let data = queryOptionDocumentSnapShot.data()
                    
                    let id = data["id"] as? String ?? ""
                    let option = data["option"] as? String ?? ""
                    
                    let optionModel = QuizOptionsModel(id: id, option: option)
                    
                    return optionModel
                }
            }
        return options
    }
    
}
