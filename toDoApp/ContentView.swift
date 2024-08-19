//
//  ContentView.swift
//  toDoApp
//
//  Created by Bayram Yeleç on 19.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var textTextField: String = ""
    @State var yapilacakListesi: [String] = []
    @State var isCompleted: [Bool] = []
     
    let yapilacakListesiKey = "yapilacakListesi"
    let isCompletedKey = "isCompleted"
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    TextField("Bir şeyler yaz..", text: $textTextField)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.15))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .cornerRadius(10)
                    
                    Button(action: {
                        if textTextField.count >= 1 {
                            yapilacakListesi.append(textTextField)
                            isCompleted.append(false) // Yeni öğe eklendiğinde isCompleted'a false ekleniyor
                            textTextField = ""
                            saveData()
                        }
                    }, label: {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(textTextField.count >= 1 ? .blue : .gray)
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .cornerRadius(10)
                    })
                    
                    List {
                        Section("Yapılacak Listesi") {
                            ForEach(yapilacakListesi.indices, id: \.self ) { index in
                                HStack {
                                    Text(yapilacakListesi[index])
                                        .strikethrough(isCompleted[index])
                                        .onTapGesture {
                                            isCompleted[index].toggle()
                                            saveData()
                                        }
                                }
                            }
                            .onDelete(perform: { indexSet in
                                yapilacakListesi.remove(atOffsets: indexSet)
                                isCompleted.remove(atOffsets: indexSet)
                                saveData()
                            })
                        }
                    }
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("ToDo App")
                .onAppear{
                    loadData()
                }
            }
        }
        .padding()
    }
    
    func saveData(){
        
        UserDefaults.standard.set(yapilacakListesi, forKey: yapilacakListesiKey)
        UserDefaults.standard.set(isCompleted, forKey: isCompletedKey)
        
    }
    
    func loadData(){
        
        if let savedList = UserDefaults.standard.stringArray(forKey: yapilacakListesiKey) {
            yapilacakListesi = savedList
        }
        if let savedComp = UserDefaults.standard.array(forKey: isCompletedKey) as? [Bool] {
            isCompleted = savedComp
        }
        
    }
    
}

#Preview {
    ContentView()
}
