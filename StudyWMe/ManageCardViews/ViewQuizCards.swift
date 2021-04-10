//
//  ViewQuizCards.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import SwiftUI
import Firebase

struct ViewQuizCards: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String
    @State var isAddCardSheetShown: Bool = false
    @State var quizCardCategory: QuizCardCategory
    @ObservedObject var quizCards: QuizCards = QuizCards()
//    @State var quizCardCategoryId: String

    
    //Sample data
//    @State var quizCardsModel: [QuizCardModel] = [QuizCardModel]()
    
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
                    AddQuizCardCategoryView(quizCardCat: $quizCardCategory, isNewCat: false)
                }
                
            }

            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(self.quizCards.quizCards, id: \.quizCardId) { quizCard in
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
        .onAppear(perform: {
//            self.quizCardsModel = self.quizCardCategory.quizCards
            self.quizCards.fetchQuizCardsData(studentUID: Auth.auth().currentUser!.uid, quizCardCatId: self.quizCardCategory.quizCardCatId)
        })
    }
    
}

struct ViewQuizCards_Previews: PreviewProvider {
    static var previews: some View {
        ViewQuizCards(title: "Hello", quizCardCategory: QuizCardCategory())
    }
}
