//
//  AFlashCard.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-04.
//

import SwiftUI

struct AFlashCard: View {
    @State var title: String
    @State var details: String
    @State var color: Color
    
    @State var isTapped: Bool = false

    var body: some View {
        ZStack {
            if !isTapped {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(color)
                        .frame(width: 600, height: 800)
                        .shadow(color: .black, radius: 16, x: 0, y: 20 )
                    Text(title)
                        .font(Font.custom("Noteworthy", size: 50).bold())
                        .foregroundColor(Color.white)
                }
                
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: 600, height: 800)
                        .shadow(color: .black, radius: 16, x: 0, y: 20 )
    
                    Text( details)
                        .font(Font.custom("Noteworthy", size: 50).bold())
                        .foregroundColor(Color.black)
                        .transition(.scale)
    
                }
                .rotation3DEffect(Angle(degrees: self.isTapped ? 180 : 0), axis: (x:0,y:1,z:0))
            }
            
        }//VStack
        .rotation3DEffect(Angle(degrees: self.isTapped ? 180 : 0), axis: (x:0,y:1,z:0))
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.8)){
                isTapped.toggle()
            }
        }

    }
}

struct AFlashCard_Previews: PreviewProvider {
    static var previews: some View {
        AFlashCard(title: "Who am I?", details: "Sharan", color: Color("LightOrchid"))
    }
}
