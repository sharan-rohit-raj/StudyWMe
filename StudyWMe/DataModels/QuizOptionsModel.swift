//
//  QuizOptionsModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-04.
//

import Foundation
import FirebaseFirestoreSwift

struct QuizOptionsModel: Identifiable, Codable {
    
    @DocumentID var id: String? = UUID().uuidString
    var optionID: String = ""
    var option: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case optionID
        case option
    }
}
