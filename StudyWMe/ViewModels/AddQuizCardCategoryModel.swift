//
//  AddQuizCardCategoryModel.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import Foundation
class AddQuizCardCategoryModel: ObservableObject {
    @Published var quizCardCategoryName: String = ""
    @Published var quizCardQuestion: String = ""
    @Published var quizCardOptions: [String] = ["", "", "", ""]
    @Published var quizCardCorrectOption: Int = -1
}
