//
//  FlashQuizView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-27.
//

import SwiftUI

struct FlashQuizView: View {
    //Sample Flash Card Category
    @State var flashCardsCategories: [FlashCardCategory] = [FlashCardCategory(id: 0, title: "CP373", image: "forestFlashCard"),
                                                  FlashCardCategory(id: 1, title: "CP372",image: "moonFlashCard"),
                                                  FlashCardCategory(id: 2, title: "CP351", image: "orangeTreeFlashCard"),
                                                  FlashCardCategory(id: 3, title: "CP363", image: "raysFlashCard"),
                                                  FlashCardCategory(id: 4, title: "CP3863", image: "sunsetFlashCard")]
    //Sampe Quiz Card Category
    @State var quizCardCategories: [QuizCardCategory] = [QuizCardCategory(id: 0, title: "CP264", image: "moonBuilding"),
                                                QuizCardCategory(id: 1, title: "CP216", image: "tallBuilding"),
                                                QuizCardCategory(id: 2, title: "CP214", image: "torontoBuilding"),
                                                QuizCardCategory(id: 3, title: "CP164", image: "foggyBuilding")]
    
    @State var scrollMoved = 0
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack{
                        Text("Hello, ")
                            .font(Font.custom("Noteworthy", size: 35).bold())
                            .foregroundColor(Color("DarkPurple"))

                        Text("Student")
                            .font(Font.custom("Noteworthy", size: 35).bold())
                            .foregroundColor(Color("DarkPurple"))
                        Spacer()
                    }
                    .padding(.top, 100)
                    .padding(.leading, 15)
                    
                    
                    //MARK:- Flash Card Category UI
                    VStack(spacing: 30){
                        HStack{
                            Text("Flash Card Category")
                                .font(Font.custom("Noteworthy", size: 25).bold())
                                .foregroundColor(Color.white)
                                .padding(.leading, 15)
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                            })
                            .padding(.trailing, 15)
                            .padding(.top, 15)
                        }
//                        .padding(.top, 30)
                        
                        //Flash Cards
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 20){
                                ForEach(flashCardsCategories) { flashCard in
                                    GeometryReader{ geometry in
                                        CardView(title: flashCard.title, image: flashCard.image)
                                            .rotation3DEffect(
                                                Angle(degrees: (Double(geometry.frame(in: .global).minX) - 80) / -30),
                                                axis: (x: 0, y: 2.5, z: 0)
                                            )
                                    }
                                    .frame(width: 380, height: 600)

                                }
                            }.padding(80)
                            Spacer()
                        }
                        .padding(.top, 80)
                        .frame(width: UIScreen.main.bounds.width * 0.95, height: 600)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 700)
                    .background(Color("DarkPurple"))
                    .cornerRadius(25)
                    .shadow(color:  Color("LightPurple"), radius: 10, x: 0.0, y: 10)
                    .padding(.top, 25)

                    
                    
                    //MARK:- Quiz Card Category UI
                    VStack(spacing: 30){
                        HStack{
                            Text("Quiz Category")
                                .font(Font.custom("Noteworthy", size: 25).bold())
                                .foregroundColor(Color.white)
                                .padding(.leading, 15)
                            Spacer()
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                            })
                            .padding(.trailing, 15)
                            .padding(.top, 15)
                        }
    //                    .padding(.top, 30)
                        
                        //Quiz Cards
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 20){
                                ForEach(quizCardCategories) { quizCard in
                                    GeometryReader{ geometry in
                                        CardView(title: quizCard.title, image: quizCard.image)
                                            .rotation3DEffect(
                                                Angle(degrees: (Double(geometry.frame(in: .global).minX) - 80) / -30),
                                                axis: (x: 0, y: 2.5, z: 0)
                                            )
                                    }
                                    .frame(width: 380, height: 600)

                                }
                            }.padding(80)
                            Spacer()
                        }
                        .padding(.top, 80)
                        .frame(width: UIScreen.main.bounds.width, height: 600)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 700)
                    .background(Color("DarkPurple"))
                    .cornerRadius(25)
                    .shadow(color: Color("LightPurple"), radius: 10, x: 0.0, y: 10)
                    .padding(.top, 25)
                    
                    Spacer(minLength: 40)


                }//VStack
            }.edgesIgnoringSafeArea(.top)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func calculateWidth() -> CGFloat{
        let screen = UIScreen.main.bounds.width - 80
        let width = screen - (4*80)
        return width
    }
}

struct FlashQuizView_Previews: PreviewProvider {
    static var previews: some View {
        FlashQuizView()
    }
}
