//
//  ViewQuizCards.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import SwiftUI

struct ViewQuizCards: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    @State var isAddCardSheetShown: Bool = false
    
    //Sample data
    @State var quizCards: [QuizCardModel] = [
        QuizCardModel(
            id: 0,
            question: "What is my name?",
            options: [QuizOptionsModel(id: 0, option: "Sharan"),
                      QuizOptionsModel(id: 1, option: "Rohit"),
                      QuizOptionsModel(id: 2, option: "Raj"),
                      QuizOptionsModel(id: 3, option: "All of the above")],
            correctOption: 3),
        QuizCardModel(
            id: 1,
            question: "What is my favourite colour?",
            options: [QuizOptionsModel(id: 0, option: "Pink"),
                       QuizOptionsModel(id: 1, option: "Red"),
                       QuizOptionsModel(id: 2, option: "Yellow"),
                       QuizOptionsModel(id: 3, option: "Purple")],
            correctOption: 3),
        QuizCardModel(
            id: 2,
            question: "What is my favourite movie?",
            options: [QuizOptionsModel(id: 0, option: "Avengers"),
                       QuizOptionsModel(id: 1, option: "Tenet"),
                       QuizOptionsModel(id: 2, option: "Master"),
                       QuizOptionsModel(id: 3, option: "ABC")],
            correctOption: 2),
        QuizCardModel(
            id: 3,
            question: "What do I live?",
            options: [QuizOptionsModel(id: 0, option: "Waterloo"),
                       QuizOptionsModel(id: 1, option: "Mississauga"),
                       QuizOptionsModel(id: 2, option: "Toronto"),
                       QuizOptionsModel(id: 3, option: "Scarborough")],
            correctOption: 0),
    ]
    
    var body: some View {
        VStack {
            HStack{
                Button(action : {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color("DarkPurple"))
                        .padding()
                        .padding(.top, 0.5)
                }
                Spacer()
                Text(title)
                    .font(Font.custom("Noteworthy", size: 50).bold())
                    .foregroundColor(Color("DarkPurple"))
                Spacer()
                Button(action : {
                    self.isAddCardSheetShown.toggle()
                }){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color("DarkPurple"))
                        .padding()
                        .padding(.top, 0.5)
                }
                .sheet(isPresented: $isAddCardSheetShown){
                    AddQuizCardCategoryView(quizCardCat: title, isNewCat: false)
                }
                
            }

            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(quizCards) { quizCard in
                        GeometryReader{ geometry in
                            AQuizCard(question: quizCard.question, options: quizCard.options, correctOptionIndex: quizCard.correctOption)
                                .rotation3DEffect(
                                    Angle(degrees: (Double(geometry.frame(in: .global).minX) - 80) / -30),
                                    axis: (x: 0, y: 2.5, z: 0)
                                )
                        }
                        .frame(width: 600, height: 800)
                    }
                }.padding(40)
                Spacer()
            }
            
            Spacer()
        }//VStack
    }
    
}

struct ViewQuizCards_Previews: PreviewProvider {
    static var previews: some View {
        ViewQuizCards(title: "Hello")
    }
}
