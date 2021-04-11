//
//  FlashQuizView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-27.
//

import SwiftUI
import Firebase

struct FlashQuizView: View {
    //Flash Card Category
    @ObservedObject var flashCardsCategories: FlashCardCategories
        
    //Quiz Card Category
    @ObservedObject var quizCardCategoriesModel: QuizCardCategories
    
    
    @State var colors: [[Color]] = [[Color.black, Color("Grape"), Color("Peach"), Color("Sky"), Color.black],
                                    [Color.black,Color("Sky"), Color("Peach"), Color.black],
                                    [Color.black,Color("KindaBlue"), Color("Grape"),Color("Sky"), Color.black],
                                    [Color.black,Color("LightMagenta"), Color("KindaBlue"), Color("Grape"), Color.black]]
    
    @State var showAddCardCategory = false
    @State var showAddQuizCardCategory = false
    @State var displayName = Auth.auth().currentUser?.displayName ?? "Student"
    @State var isAddFlashCatClosed: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack{
                        Text("Hello, ")
                            .font(Font.custom("Noteworthy", size: 35).bold())
                            .foregroundColor(Color("DarkPurple"))

                        Text(displayName)
                            .font(Font.custom("Noteworthy", size: 35).bold())
                            .foregroundColor(Color("DarkPurple"))
                        Spacer()
                    }
                    .padding(.top, 100)
                    .padding(.leading, 15)
                    
                    
                    //MARK:- Flash Card Category UI
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color("DarkPurple"), Color("DarkPurple"), Color("DarkMagenta"), Color("LightMagenta"),Color("Peach")]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                            
                        )
//                        VisualEffectBlur(
//                            blurStyle: .systemUltraThinMaterialDark
//                        )
                        
                        VStack(spacing: 30){
                            HStack{
                                Text("Flash Card Category")
                                    .font(Font.custom("Noteworthy", size: 25).bold())
                                    .foregroundColor(Color.white)
                                    .padding(.leading, 15)
                                Spacer()
                                
                                Button(action: {
                                    self.isAddFlashCatClosed = false
                                    self.showAddCardCategory.toggle()
                                }){
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 15)
                                        .padding(.top, 15)
                                }
                                .sheet(isPresented: $showAddCardCategory){
                                    AddFlashCardCategoryView(flashCardCatID: "", flashCardTitle: "", isNewCat: true, isAddFlashCatClosed: self.$isAddFlashCatClosed)
                                }
                                .background(Color.white.opacity(0))
                                

                            }
    //                        .padding(.top, 30)
                            
                            //Flash Cards
                            if flashCardsCategories.flashCardCategories.count != 0 {
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 20){
                                        ForEach(flashCardsCategories.flashCardCategories, id: \.flashCardCarId) { flashCard in
                                            GeometryReader{ geometry in
                                                CardView(title: flashCard.title, image: flashCard.image, colors: colors.randomElement()!, isFlashCard: true, flashCardCategory: flashCard, quizCardCategory: QuizCardCategory())
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
                            } else {
                                Text("There are currently no Flash Card Categories. Click on the + button to add.")
                                    .font(Font.custom("Noteworthy", size: 35).bold())
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.65, height: 600, alignment: .center)
                                    .offset(y: -40)
                                    
                            }
                        }

                    }
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 700)
                    .background(Color.clear)
                    .cornerRadius(25)
                    .shadow(color:  Color("LightPurple"), radius: 10, x: 0.0, y: 10)
                    .padding(.top, 25)

                    
                    
                    //MARK:- Quiz Card Category UI
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color("DarkPurple"), Color("DarkPurple"), Color("DarkMagenta"), Color("LightMagenta"),Color("Peach")]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                            
                        )
                        VStack(spacing: 30){
                            HStack{
                                Text("Quiz Category")
                                    .font(Font.custom("Noteworthy", size: 25).bold())
                                    .foregroundColor(Color.white)
                                    .padding(.leading, 15)
                                Spacer()
                                
                                Button(action: {
                                    showAddQuizCardCategory.toggle()
                                }){
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 15)
                                        .padding(.top, 15)
                                }
                                .sheet(isPresented: $showAddQuizCardCategory){
                                    AddQuizCardCategoryView(quizCardCatID: "",quizCardCatTitle: "", isNewCat: true)
                                }
                                .background(Color.white.opacity(0))
                            }
        //                    .padding(.top, 30)
                            
                            //Quiz Cards
                            if quizCardCategoriesModel.quizCardCategories.count != 0 {
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 20){
                                        ForEach(quizCardCategoriesModel.quizCardCategories, id: \.quizCardCatId) { quizCard in
                                            GeometryReader{ geometry in
                                                CardView(title: quizCard.title, image: quizCard.image, colors: colors.randomElement()!, isFlashCard: false, flashCardCategory: FlashCardCategory(), quizCardCategory: quizCard)
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
                            } else {
                                Text("There are currently no Quiz Card Categories. Click on the + button to add.")
                                    .font(Font.custom("Noteworthy", size: 35).bold())
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width * 0.65, height: 600, alignment: .center)
                                    .offset(y: -40)
                            }
                        }

                    }
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 700)
                    .background(Color.clear)
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
        .onAppear(perform: {
            displayName = Auth.auth().currentUser?.displayName ?? "Student"
//            self.flashCardsCategories.fetchData(studentUID: Auth.auth().currentUser!.uid)
//            self.quizCardCategoriesModel.fetchData(studentUID: Auth.auth().currentUser!.uid)
        })
    }
    
    func calculateWidth() -> CGFloat{
        let screen = UIScreen.main.bounds.width - 80
        let width = screen - (4*80)
        return width
    }
}

struct FlashQuizView_Previews: PreviewProvider {
    static var previews: some View {
        FlashQuizView(flashCardsCategories: FlashCardCategories(), quizCardCategoriesModel: QuizCardCategories())
    }
}
