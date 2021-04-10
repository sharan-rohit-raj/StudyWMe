//
//  AddFlashCardCategoryModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AddFlashCardCategoryModel: ObservableObject {
    @Published var flashCardCategory: FlashCardCategory = FlashCardCategory(id: UUID().uuidString, flashCardCarId: "", title: "", image: "", flashCards: [FlashCardModel]())
    private var db = Firestore.firestore()
    
    private var randomImages: [String] = ["forestFlashCard",
                                          "moonFlashCard",
                                          "orangeTreeFlashCard",
                                          "raysFlashCard",
                                          "sunsetFlashCard",
                                          "moonBuilding",
                                          "tallBuilding",
                                          "torontoBuilding",
                                          "foggyBuilding"]
    
    func saveFlashCategory(flashCardCategory: FlashCardCategory, studentUID: String, handler: @escaping ((Error?) -> Void)) {
        print("UUID: \(flashCardCategory.id ?? "nil")")
        print("Title: \(flashCardCategory.title)")
        print("Image: \(flashCardCategory.image)")
        print("Number of flash cards: \(flashCardCategory.flashCards.count)")
        
        do {
            let _ = try db.collection("students").document(studentUID)
                .collection("flashCardCategories")
                .document(flashCardCategory.id!)
                .setData(from: flashCardCategory, completion: handler)
        }catch{
            print(error)
        }
    }
    
}
