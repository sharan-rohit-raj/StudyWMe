//
//  AddFlashCardCategoryModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

/// Class that manges flash card category related stuff
class ManageFlashCardCategoryModel: ObservableObject {
    private var categorytitleLimit = 30
    @Published var flashCardCategory: FlashCardCategory = FlashCardCategory(id: UUID().uuidString, flashCardCarId: "", title: "", image: "", flashCards: [FlashCardModel]()) {
        didSet{
            if flashCardCategory.title.count > categorytitleLimit {
                flashCardCategory.title = String(flashCardCategory.title.prefix(categorytitleLimit))
            }
        }
    }
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
    
    /// Function to save a new flash card category
    /// - Parameters:
    ///   - flashCardCategory: Flash card category that is to be saved
    ///   - studentUID: UID of the student
    ///   - handler: Handler to handle the throwback even
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
    
    /// Saves new set of flash cards in the category with given category ID
    /// - Parameters:
    ///   - flashCardCategoryID: Flash Card Category ID
    ///   - studentUID: UID of the student
    ///   - flashCards: New set of flash cards to be added
    ///   - handler: handler to catch throw back events
    func saveNewFlashCardsInCategory(flashCardCategoryID: String, studentUID: String, flashCards: [FlashCardModel], handler: @escaping ((Error?) -> Void)) {
        
        db.collection("students").document(studentUID)
            .collection("flashCardCategories").document(flashCardCategoryID)
            .getDocument { (document, error) in
                if let document = document, document.exists {
                    do {
                        var flashCardCategory = try document.data(as: FlashCardCategory.self)
                        //Add the new flash cards
                        flashCardCategory!.flashCards.append(contentsOf: flashCards)
                        //Save the quiz card category with new quiz cards
                        self.saveFlashCategory(flashCardCategory: flashCardCategory!, studentUID: studentUID, handler: handler)
                    }catch{
                        print(error)
                    }
                   
                }else{
                    print("Document does not exist")
                }
            }
    }
    
    /// Deletes a flash card category with given ID
    /// - Parameters:
    ///   - flashCardCategoryID: Flash Card Category ID that is to be deleted
    ///   - studentUID: UID of the student
    ///   - handler: Handler to handle the throwback event of deletion
    func deleteFlashCardCategory(flashCardCategoryID: String, studentUID: String, handler: @escaping ((Error?) -> Void)) {
        db.collection("students").document(studentUID)
            .collection("flashCardCategories").document(flashCardCategoryID)
            .delete(completion: handler)
    }
    
}
