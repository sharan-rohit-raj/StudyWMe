//
//  AQuizCard.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-04.
//

import SwiftUI

struct AQuizCard: View {
    @State var question: String
    @State var options: [QuizOptionsModel]
    @State var correctOptionIndex: Int
    @State var isTapped = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(self.isTapped ?
                    LinearGradient(
                        gradient: Gradient(colors: [Color("Lime"), Color("Sky")]), startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                    :
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black, radius: 16, x: 0, y: 20 )
            
            VStack {
                Text(question)
                    .font(Font.custom("Noteworthy", size: 50).bold())
                    .foregroundColor(self.isTapped ? Color.white : Color.black)
                    .frame(width: 500, height: 200, alignment: .center)
                    .padding(.bottom, 40)
                
                if !self.isTapped {
                    ForEach(options) { option in
                        Button(action:  {
                            if option.id == self.correctOptionIndex {
                                withAnimation (.easeOut){
                                    self.isTapped.toggle()
                                }
                               
                            }
                        }, label: {
                            Text(option.option)
                            .font(Font.custom("Noteworthy", size: 30))
                            .foregroundColor(Color.black)
                            .frame(width: 500, alignment: .center)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color("DarkPurple"), lineWidth: 1))
     
                        })

                        
                            .padding(.bottom, 30)
                    }
                    
                } else {
                    
                    VStack (spacing: 40){
                        Text(options[correctOptionIndex].option)
                            .font(Font.custom("Noteworthy", size: 45).bold())
                            .foregroundColor(.white)
                            .transition(.scale)
                     
                        Button(action: {self.isTapped.toggle()}, label: {
                            HStack(spacing: 20) {
                                Image(systemName: "arrow.uturn.backward.circle.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 45, height: 45)
                                
                                
                                Text("Retry")
                                    .font(Font.custom("Noteworthy", size: 30).bold())
                                .foregroundColor(.white)
                                    
                            }
                            .frame(width: 200, height: 80)
                            .overlay(Capsule().stroke(Color.white))
                        })
                    }
                }
            }
            
        }//ZStack
        .frame(width: 600, height: 800)
        
    }
}

struct AQuizCard_Previews: PreviewProvider {

    static var previews: some View {
        AQuizCard(question: "What is my name?", options: [QuizOptionsModel(id: 0, option: "Sharan"),
                  QuizOptionsModel(id: 1, option: "Rohit"),
                  QuizOptionsModel(id: 2, option: "Raj"),
                  QuizOptionsModel(id: 3, option: "All of the above")], correctOptionIndex: 3)
    }
}
