//
//  CatFactView.swift
//  project-sarah
//
//  Created by Sarah Tsabitah on 29/07/23.
//

import Foundation
import SwiftUI

struct Cat: Hashable, Codable {
    let fact: String
    let length: Int
}

class CatViewModel : ObservableObject {
    @Published var cats : Cat = Cat(fact: "GIVE YOU REASON TO LOVE CAT EVEN MORE \n \n 😃", length: 90)
    
    func fetchData() {
        guard let url = URL(string: "https://catfact.ninja/fact") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Cat.self, from: data)
                DispatchQueue.main.async {
                    self.cats = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct CatFactView: View {
    @StateObject var catViewModel = CatViewModel()
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
            VStack(spacing: 100) {
                VStack {
                    ZStack {
                        ZStack{
                            Rectangle()
                                .frame(width: 300, height: 350)
                                .foregroundColor(Color.purple)
                                .cornerRadius(70)
                                .shadow(radius: 10)
                            VStack(spacing: -75) {
                                Text("\(catViewModel.cats.fact)")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 300, height: 300)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle("CAT FACT")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        ZStack{
                            
                            VStack{
                                Text("🐱")
                                    .offset(y: -200)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 150, weight: .bold))
                            }
                        }
                    }
                }
                
              
                VStack(spacing: 15) {
                    Button(action: {
                        catViewModel.fetchData()
                    },
                           label: {
                        Text("Give me fact!")
                            .bold()
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    })
                    
                    Button("Back to main menu") {
                        presentationModes.wrappedValue.dismiss()
                    }
                }
                
            }
        }
        
    }


struct CatFactView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactView()
    }
}

