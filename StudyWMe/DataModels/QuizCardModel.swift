//
//  QuizCardModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import Foundation
struct QuizCardModel: Identifiable {
     var id: Int = -1
     var question: String = ""
     var options: [QuizOptionsModel] = [QuizOptionsModel]()
     var correctOption: Int = -1
}
