//
//  FlashCardView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-28.
//

import SwiftUI

struct CardView: View {
    @State var title:String
    @State var image:String
    @State var colors: [Color]
    @State var isFlashCard: Bool
    @State var isSheetPresented: Bool = false
    @State var flashCardCategory: FlashCardCategory
    @State var quizCardCategory: QuizCardCategory
    @State var isLongPressed: Bool = false
    
    
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 450)
                .blur(radius: 4)
            
            if !self.isLongPressed {
                Text(title)
                    .font(Font.custom("Noteworthy", size: 40)).bold()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
            }else{
                Button(action: {
                   print("Delete \(title)")
                }, label: {
                    HStack(spacing: 20) {
                        Image(systemName: "trash")
                        .resizable()
                            .foregroundColor(Color.white)
                        .frame(width: 45, height: 45)
                        
                        
                        Text("Delete")
                            .font(Font.custom("Noteworthy", size: 30).bold())
                            .foregroundColor(Color.white)
                            
                    }
                    .frame(width: 200, height: 80)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                })
            }

        }
        .frame(width: 350, height: 450)
        .cornerRadius(25)
        .shadow(color: Color("LightOrchid").opacity(0.75), radius: 10, x: 0, y: 20)
        .onTapGesture {
            if self.isLongPressed{
                self.isLongPressed.toggle()
            }
            isSheetPresented.toggle()
        }
        .onLongPressGesture {
            withAnimation {
                self.isLongPressed.toggle()
            }
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            if isFlashCard{
                ViewFlashCards.init(title: title, flashCardCategoryId: flashCardCategory.flashCardCarId)
            }else{
                ViewQuizCards.init(title: title, quizCardCategoryID: quizCardCategory.quizCardCatId)
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "iPhone Programming", image: "moonFlashCard", colors: [Color("Grape"), Color("Sky")], isFlashCard: true, flashCardCategory: FlashCardCategory(id: "", flashCardCarId: "", title: "", image: "", flashCards: []), quizCardCategory: QuizCardCategory())
    }
}
