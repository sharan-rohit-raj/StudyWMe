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

    
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 450)
                .blur(radius: 4)
            
//            LinearGradient(
//                gradient: Gradient(colors: colors),
//                startPoint: .bottom,
//                endPoint: .top
//            )

            Text(title)
                .font(Font.custom("Noteworthy", size: 40)).bold()
                .foregroundColor(.white)
                .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
        }
        .frame(width: 350, height: 450)
        .cornerRadius(25)
        .shadow(color: Color("LightOrchid").opacity(0.75), radius: 10, x: 0, y: 20)
        .onTapGesture {
            isSheetPresented.toggle()
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            if isFlashCard{
                ViewFlashCards.init(title: title)
            }else{
                ViewQuizCards.init(title: title)
            }
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "iPhone Programming", image: "moonFlashCard", colors: [Color("Grape"), Color("Sky")], isFlashCard: true)
    }
}
