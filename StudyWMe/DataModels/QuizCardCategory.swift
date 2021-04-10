//
//  QuizCard.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-27.
//

import Foundation
import SwiftUI
import  FirebaseFirestoreSwift

struct QuizCardCategory: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
     var quizCardCatId: String = ""
     var title: String = ""
     var image: String = ""
     var quizCards: [QuizCardModel] = []
    
    enum CodingKeys : String, CodingKey {
        case id
        case quizCardCatId
        case title
        case image
        case quizCards
    }
}
