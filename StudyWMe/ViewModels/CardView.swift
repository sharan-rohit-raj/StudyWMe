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
    
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .frame(width: 350, height: 450)
                .border(Color.black, width: 1)
                .cornerRadius(25)
                .shadow(color: Color("LightPurple"), radius: 10, x: 0, y: 20)

            
            Text(title)
                .font(Font.custom("Noteworthy", size: 40)).bold()
                .foregroundColor(.white)
                .frame(width: 305, height: 430, alignment: .topLeading)
                .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "iPhone Programming", image: "moonFlashCard")
    }
}
