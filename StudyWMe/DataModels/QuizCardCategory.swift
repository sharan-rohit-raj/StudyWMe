//
//  QuizCard.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-27.
//

import Foundation
import SwiftUI

struct QuizCardCategory: Identifiable {
     var id: Int = -1
     var title: String = ""
     var image: String = ""
     var quizCards: [QuizCardModel] = []
}
