//
//  FlashCardModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
import FirebaseFirestoreSwift

struct FlashCardModel: Identifiable, Codable {
     @DocumentID var id: String? = UUID().uuidString
     var flashCardId: String = ""
     var title: String = ""
     var details: String = ""
    
    enum CodingKeys : String, CodingKey {
        case id
        case flashCardId
        case title
        case details
    }
}
