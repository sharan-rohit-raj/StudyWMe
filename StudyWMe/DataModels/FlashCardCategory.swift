//
//  FlashCard.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-27.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct FlashCardCategory: Identifiable, Codable {
     @DocumentID var id: String? = UUID().uuidString
     var flashCardCarId: String = ""
     var title: String = ""
     var image: String = ""
     var flashCards: [FlashCardModel] = []
    
    enum CodingKeys : String, CodingKey {
        case id
        case flashCardCarId
        case title
        case image
        case flashCards
    }
}
