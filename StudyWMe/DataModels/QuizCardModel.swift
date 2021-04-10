//
//  QuizCardModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
import FirebaseFirestoreSwift

struct QuizCardModel: Identifiable, Codable {
     @DocumentID var id: String? = UUID().uuidString
     var quizCardId: String? = ""
     var question: String = ""
     var options: [QuizOptionsModel] = [QuizOptionsModel]()
     var correctOption: String = "0"
    
    enum CodingKeys: String, CodingKey {
        case id
        case quizCardId
        case question
        case options
        case correctOption
    }
}
