//
//  AddQuizCardCategoryView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-04-03.
//

import SwiftUI
import Firebase

struct AddQuizCardCategoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var id = 0
    @State var quizCardCatID: String
    @State var quizCardCatTitle: String
    @State var isNewCat: Bool
    @State var quizCards: [QuizCardModel] = [QuizCardModel]()
    @State var quizCard: QuizCardModel = QuizCardModel()
    @State var quizOption: [QuizOptionsModel] = [QuizOptionsModel(id: "0", optionID: "0", option: ""), QuizOptionsModel(id: "1", optionID: "1", option: ""), QuizOptionsModel(id: "2", optionID: "2", option: ""), QuizOptionsModel(id: "3", optionID: "3", option: "")]
    @StateObject var model: ManageQuizCardCategoryModel = ManageQuizCardCategoryModel()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State var isOptionsPressed:[Bool] = [false, false, false, false]
    @ObservedObject var monitor = NetworkMonitor()
    @State var alertTypeAddMore: AlertTypeAddMore = .categoryTitleEmpty
    @State var alertTypeSave: AlertTypeSave = .success
    @State var isShowDialogAddMore = false
    @State var isDialogSave = false
    @State var errorMessage = ""
    @State var isLoading = false
    @State var studentUID = Auth.auth().currentUser?.uid
    
    enum AlertTypeAddMore {
        case categoryTitleEmpty, quizCardDetailsEmpty, connectionError, correctOptionNotChosen
    }
    enum AlertTypeSave {
        case categoryTitleEmpty, quizCardsEmpty, connectionError, otherError, success
    }
    
    @State var randomImages: [String] = ["forestFlashCard",
                                          "moonFlashCard",
                                          "orangeTreeFlashCard",
                                          "raysFlashCard",
                                          "sunsetFlashCard",
                                          "moonBuilding",
                                          "tallBuilding",
                                          "torontoBuilding",
                                          "foggyBuilding"]
    
    func resetQuizCard() {
        quizCard.id = UUID().uuidString
        quizCard.question = ""
        quizCard.options = []
        quizCard.correctOption = "0"
        quizOption = [QuizOptionsModel(id: "0", optionID: "0", option: ""), QuizOptionsModel(id: "1", optionID: "1", option: ""), QuizOptionsModel(id: "2", optionID: "2", option: ""), QuizOptionsModel(id: "3", optionID: "3", option: "")]
        isOptionsPressed = [false, false, false, false]
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("LightOrchid"), Color.white]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                    .ignoresSafeArea()
                
                VStack{
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                        ZStack{
                            if isNewCat{
                                TextField("Enter Quiz Cards Category", text: $model.quizCardCategory.title)
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .foregroundColor(Color("DarkPurple"))
                                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            }
                            else{
                                Text(quizCardCatTitle)
                                .font(Font.custom("Noteworthy", size: 20))
                                .foregroundColor(Color("DarkPurple"))
                            }

                        }
                            .padding(.horizontal)

                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 60)
                        .background(Color.white)
                            .clipShape(Capsule())
                    }
                    .shadow(color: Color("LightPurple"), radius: 10, x: 0, y: 10)
                    .padding(.horizontal)
                    .padding(.top, 80)
                        
                    //Quiz Card
                    ZStack{
                        VStack{
                            Text("Quiz Card Question")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Enter Quiz Card Question", text: $quizCard.question)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            Text("Quiz Card Options")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                                .padding(.top, 50)
                            
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                HStack{
                                    TextField("Option 1", text: $quizOption[0].option)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                    Button(action: {
                                        isOptionsPressed = [true, false, false, false]
                                    }) {
                                        if !isOptionsPressed[0] {
                                            Image(systemName: "circle.circle")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color("DarkPurple"))
                                        } else {
                                            Image(systemName: "circle.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.green)
                                        }
                                            
                                    }
                                }
                                .padding(.horizontal)
                                .frame(height: 60)
                                .background(isOptionsPressed[0] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                HStack{
                                    TextField("Option 2", text: $quizOption[1].option)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                    Button(action: {
                                        isOptionsPressed = [false, true, false, false]
                                    }) {
                                        if !isOptionsPressed[1] {
                                            Image(systemName: "circle.circle")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color("DarkPurple"))
                                        } else {
                                            Image(systemName: "circle.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.green)
                                        }
                                            
                                    }
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[1] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)
    
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                HStack{
                                    TextField("Option 3", text: $quizOption[2].option)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                    Button(action: {
                                        isOptionsPressed = [false, false, true, false]
                                    }) {
                                        if !isOptionsPressed[2] {
                                            Image(systemName: "circle.circle")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color("DarkPurple"))
                                        } else {
                                            Image(systemName: "circle.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.green)
                                        }
                                            
                                    }
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[2] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                HStack{
                                    TextField("Option 4", text: $quizOption[3].option)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                    Button(action: {
                                        isOptionsPressed = [false, false, false, true]
                                    }) {
                                        if !isOptionsPressed[3] {
                                            Image(systemName: "circle.circle")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color("DarkPurple"))
                                        } else {
                                            Image(systemName: "circle.circle.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.green)
                                        }
                                            
                                    }
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(isOptionsPressed[3] ? Color.green.opacity(0.175): Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            Text("Note: Please press on the correct option's circle button")
                                .lineLimit(2)
                                .font(Font.custom("Noteworthy", size: 14).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                                .padding(.top, 10)
                            
                        }//VStack

                    }//ZStack
                    .frame(width: 500, height: 600)
                    .background(Color.white)
                    .ignoresSafeArea()
                    .cornerRadius(20)
                    .shadow(color: Color("LightPurple"), radius: 10, x: 0, y: 10)
                    .padding(.top, 30)
                    
                    
                    HStack {
                        Button(action: {
                            self.mode.wrappedValue.dismiss()
                        }, label: {
                            Text("Cancel").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color.yellow)
                                .clipShape(Capsule())
                        })
                        .shadow(color: Color.yellow.opacity(0.25), radius: 10, x: 0, y: 10)
                        Button(action: {
                            //Add the new FlashCard to the flashCards array
                            if self.isNewCat && model.quizCardCategory.title.isEmpty {
                                self.alertTypeAddMore = .categoryTitleEmpty
                                self.isShowDialogAddMore.toggle()
                                
                            }else if quizCard.question.isEmpty ||
                                        quizOption[0].option == "" || quizOption[1].option == "" ||
                                        quizOption[2].option == "" || quizOption[3].option == ""{
                                self.alertTypeAddMore = .quizCardDetailsEmpty
                                self.isShowDialogAddMore.toggle()
                                
                            }else if self.isOptionsPressed == [false, false, false, false] {
                                self.alertTypeAddMore = .correctOptionNotChosen
                                self.isShowDialogAddMore.toggle()
                            }
                            
                            else{
                                //Add an Id to the quiz card
                                quizCard.id = UUID().uuidString
                                quizCard.quizCardId = quizCard.id
                                //Add the options to the quiz card
                                quizCard.options = quizOption
                                //Get the index of the correct option
                                quizCard.correctOption = String(self.isOptionsPressed.firstIndex(of: true)!)
                                //Add the quiz card to the array
                                quizCards.append(quizCard)
                                //Clear all the fields for new quiz card
                                resetQuizCard()
                            }
                        }, label: {
                            Text("Add More").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color.white)
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color("DarkPurple"))
                                .clipShape(Capsule())
                        })
                        .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
                        .alert(isPresented: $isShowDialogAddMore) {
                            switch(alertTypeAddMore) {
                            case .categoryTitleEmpty:
                                return Alert(title: Text("Error"), message: Text("Category title cannot be left empty"), dismissButton: .default(Text("Okay")))
                            case .quizCardDetailsEmpty:
                                return Alert(title: Text("Error"), message: Text("Quiz card details must not be left empty"), dismissButton: .default(Text("Okay")))
                            case .connectionError:
                                return Alert(title: Text("Error"), message: Text("Please check if your device is connected to the network"), dismissButton: .default(Text("Okay")))
                            case .correctOptionNotChosen:
                                return Alert(title: Text("Error"), message: Text("Please press on the correct option's circle button till it's color changes to green."), dismissButton: .default(Text("Okay")))
                            }
                        }
                        
                        
                        Button(action: {
                            //Save all the added Quiz cards
                            if !self.monitor.isConnected {
                                self.alertTypeSave = .connectionError
                                self.isDialogSave.toggle()
                            }
                            else if self.isNewCat && model.quizCardCategory.title.isEmpty {
                                self.alertTypeSave = .categoryTitleEmpty
                                self.isDialogSave.toggle()
                            }else if quizCards.isEmpty {
                                //There are no flash cards to save
                                self.alertTypeSave = .quizCardsEmpty
                                self.isDialogSave.toggle()
                            }
                            
                            //Student is adding new quiz card cat
                            if isNewCat {
                                self.isLoading.toggle()
                                model.quizCardCategory.id = UUID().uuidString
                                model.quizCardCategory.quizCardCatId = model.quizCardCategory.id!
                                model.quizCardCategory.image = self.randomImages.randomElement()!
                                model.quizCardCategory.quizCards = self.quizCards
                                
                                model.saveQuizCategory(quizCardCategory: model.quizCardCategory, studentUID: studentUID!) { error in
                                    self.isLoading.toggle()
                                    errorMessage = error?.localizedDescription ?? ""
                                    
                                    if errorMessage == "" {
                                        //Category was added
                                        self.alertTypeSave = .success
                                        self.isDialogSave.toggle()
                                    }else{
                                        //Error occurred while trying to save the category
                                        self.alertTypeSave = .otherError
                                        self.isDialogSave.toggle()
                                    }
                                }

                            }
                            // Student is adding quiz card in existing category
                            else{
                                self.isLoading.toggle()
                                model.saveQuizCardInExistingCategory(quizCardCategoryID: self.quizCardCatID, quizCards: self.quizCards, studentUID: studentUID!) { error in
                                    errorMessage = error?.localizedDescription ?? ""
                                    
                                    if errorMessage == "" {
                                        //Category was added
                                        self.alertTypeSave = .success
                                        self.isDialogSave.toggle()
                                    }else{
                                        //Error occurred while trying to save the category
                                        self.alertTypeSave = .otherError
                                        self.isDialogSave.toggle()
                                    }
                                }
                            }
                                


                            
                        }, label: {
                            Text("Save").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
                        .alert(isPresented: $isDialogSave) {
                            switch(alertTypeSave){
                            
                            case .categoryTitleEmpty:
                                return Alert(title: Text("Error"), message: Text("Category title cannot be left empty"), dismissButton: .default(Text("Okay")))
                            case .quizCardsEmpty:
                                return Alert(title: Text("Quiz Card Category Empty"), message: Text("There are no quiz cards under this category"), dismissButton: .default(Text("Okay")))
                            case .connectionError:
                                return Alert(title: Text("Error"), message: Text("Please check if your device is connected to the network"), dismissButton: .default(Text("Okay")))
                            case .otherError:
                                return Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("Okay")))
                            case .success:
                                return Alert(title: Text("Success"), message: Text("Quiz Card Category was added successfully"), dismissButton: .default(Text("Okay")) {
                                    self.mode.wrappedValue.dismiss()
                                })
                            }
                        }
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }//VStack
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .background(Color.clear)
                .onAppear { self.kGuardian.addObserver() }
                .onDisappear { self.kGuardian.removeObserver() }
                
                if self.isLoading {
                    LoaderView()
                }
            }
            .onDisappear(perform: {
                self.monitor.cancelMonitor()
            })
        }
    }
}

struct AddQuizCardCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuizCardCategoryView(quizCardCatID: "",quizCardCatTitle: "", isNewCat: true)
    }
}
