//
//  AddFlashCardCategoryView.swift
//  StudyWMe
//
//  Created by Sharan Rohit Raj Natarajan on 2021-03-30.
//

import SwiftUI
import Firebase

struct AddFlashCardCategoryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var id = 0
    @Binding var flashCardCat: FlashCardCategory
    @State var isNewCat: Bool
    @State var flashCard: FlashCardModel = FlashCardModel()
    @State var flashCards: [FlashCardModel] = [FlashCardModel]()
    @StateObject var model: AddFlashCardCategoryModel = AddFlashCardCategoryModel()
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State var alertTypeAddMore: AlertTypeAddMore = .categoryTitleEmpty
    @State var alertTypeSave: AlertTypeSave = .success
    @State var isShowDialogAddMore = false
    @State var isDialogSave = false
    @State var errorMessage = ""
    @State var isLoading = false
    @ObservedObject var monitor = NetworkMonitor()
    @Binding var isAddFlashCatClosed: Bool
    
    
    let userID = Auth.auth().currentUser?.uid
    
    enum AlertTypeAddMore {
        case categoryTitleEmpty, flashCardDetailsEmpty, connectionError, otherError
    }
    enum AlertTypeSave {
        case categoryTitleEmpty, flashCardsEmpty, connectionError, otherError, success, successFlashCardAdd
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
    
    func resetFlashCard() {
        flashCard.id = UUID().uuidString
        flashCard.title = ""
        flashCard.details = ""
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
                                TextField("Enter Flash Cards Category", text: $model.flashCardCategory.title)
                                    .font(Font.custom("Noteworthy", size: 20))
                                    .foregroundColor(Color("DarkPurple"))
                                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                            }
                            else{
                                Text(flashCardCat.title)
                                .font(Font.custom("Noteworthy", size: 20))
                                .foregroundColor(Color("DarkPurple"))
                            }

                        }
                            .padding(.horizontal)

                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 60)
                        .background(Color.white)
                            .clipShape(Capsule())
                    }
                    .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
                    .padding(.horizontal)
                    .padding(.top, 80)
                        
                    //Flash Card
                    ZStack{
                        VStack{
                            Text("Flash Card Title")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                                ZStack{
                                    TextField("Enter Flash Card Title", text: $flashCard.title)
                                        .font(Font.custom("Noteworthy", size: 18))
                                        .foregroundColor(Color("DarkPurple"))
                                }
                                    .padding(.horizontal)

                                    .frame(height: 60)
                                .background(Color("LightPurple").opacity(0.175))
                                    .clipShape(Capsule())
                            }
                            .padding(.horizontal)

                            Text("Flash Card Details")
                                .font(Font.custom("Noteworthy", size: 18))
                                .foregroundColor(Color("DarkPurple"))
                                .frame(width: 500, height: 10, alignment: .bottomLeading)
                                .offset(x: 25)
                                .padding(.top, 50)

                            TextEditor(text: $flashCard.details)
                                .frame(height: 250)
                                .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color("DarkPurple"), lineWidth: 2))
                                .foregroundColor(Color("DarkPurple"))
                                .font(Font.custom("Noteworthy", size: 18))
                                .lineSpacing(5)
                                .lineLimit(2)
                                .padding(.leading)
                                .padding(.trailing)
                                .disableAutocorrection(true)
                            
                        }

                    }//ZStack
                    .frame(width: 500, height: 600)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("LightPurple"), radius: 10, x: 0, y: 10)
                    .padding(.top, 30)
                    
                    
                    HStack {
                        Button(action: {
                            self.isAddFlashCatClosed = true
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
                            if isNewCat && model.flashCardCategory.title.isEmpty {
                                self.alertTypeAddMore = .categoryTitleEmpty
                                self.isShowDialogAddMore.toggle()
                            }
                            
                            else if flashCard.title.isEmpty || flashCard.details.isEmpty {
                                self.alertTypeAddMore = .flashCardDetailsEmpty
                                self.isShowDialogAddMore.toggle()
                            }else{
                                //Add an Id to the flash card
                                flashCard.id = UUID().uuidString
                                flashCard.flashCardId = flashCard.id!
                                //Add the flash card to the array
                                flashCards.append(flashCard)
                                //Clear all the fields for new flash card
                                resetFlashCard()
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
                            case .flashCardDetailsEmpty:
                                return Alert(title: Text("Error"), message: Text("Flash card title and/or details must not be left empty"), dismissButton: .default(Text("Okay")))
                            case .connectionError:
                                return Alert(title: Text("Error"), message: Text("Please check if your device is connected to the network"), dismissButton: .default(Text("Okay")))
                            case .otherError:
                                return Alert(title: Text("Error"), message: Text("We faced an error. Please try again."), dismissButton: .default(Text("Okay")))
                            }
                        }
                        
                        Button(action: {
                            //Save all the added flash cards
                            if !self.monitor.isConnected {
                                self.alertTypeSave = .connectionError
                                self.isDialogSave.toggle()
                            }
                            else if flashCards.isEmpty {
                                //There are no flash cards to save
                                self.alertTypeSave = .flashCardsEmpty
                                self.isDialogSave.toggle()
                            }
                            //Student is adding a new category
                            if isNewCat {
                                if model.flashCardCategory.title.isEmpty {
                                    self.alertTypeSave = .categoryTitleEmpty
                                    self.isDialogSave.toggle()
                                }else{
                                    self.isLoading.toggle()
                                    model.flashCardCategory.id = UUID().uuidString
                                    model.flashCardCategory.flashCardCarId = model.flashCardCategory.id!
                                    model.flashCardCategory.image = self.randomImages.randomElement()!
                                    model.flashCardCategory.flashCards = self.flashCards
                                }
                            }
                            //Student is adding card to an existing category
                            else{
                                self.isLoading.toggle()
                                //Add the new cards to the flash card category
                                flashCardCat.flashCards.append(contentsOf: self.flashCards)
                                model.flashCardCategory = flashCardCat
                            }
                            
                            model.saveFlashCategory(flashCardCategory: model.flashCardCategory, studentUID: userID!) { error in
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
                        }, label: {
                            Text("Save").font(Font.custom("Noteworthy", size: 20).bold())
                                .foregroundColor(Color("DarkPurple"))
                                .padding(.vertical)
                                .frame(width: 150)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .alert(isPresented: $isDialogSave) {
                            switch(alertTypeSave){
                            
                            case .categoryTitleEmpty:
                                return Alert(title: Text("Error"), message: Text("Category title cannot be left empty"), dismissButton: .default(Text("Okay")))
                            case .flashCardsEmpty:
                                return Alert(title: Text("Flash Card Category Empty"), message: Text("There are no flash cards to save under this category"), dismissButton: .default(Text("Okay")))
                            case .connectionError:
                                return Alert(title: Text("Error"), message: Text("Please check if your device is connected to the network"), dismissButton: .default(Text("Okay")))
                            case .otherError:
                                return Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("Okay")))
                            case .success:
                                return Alert(title: Text("Success"), message: Text("Flash Card Category was added successfully"), dismissButton: .default(Text("Okay")) {
                                    self.mode.wrappedValue.dismiss()
                                })
                            case .successFlashCardAdd:
                                return Alert(title: Text("Success"), message: Text("Flash Cards were added to the category successfully"), dismissButton: .default(Text("Okay")) {
                                    self.mode.wrappedValue.dismiss()
                                })
                            }
                        }
                        .shadow(color: Color("LightPurple").opacity(0.5), radius: 10, x: 0, y: 10)
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
        }
        .onDisappear(perform: {
            self.monitor.cancelMonitor()
        })
    }//body

}

struct AddFlashCardCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddFlashCardCategoryView(flashCardCat: .constant(FlashCardCategory()) , isNewCat: true, isAddFlashCatClosed: .constant(false))
    }
}
