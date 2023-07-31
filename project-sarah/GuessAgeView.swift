//
//  GuessAgeView.swift
//  project-sarah
//
//  Created by Sarah Tsabitah on 29/07/23.
//

import Foundation
import SwiftUI

struct Person: Hashable, Codable {
    let count: Int?
    let name: String?
    let age: Int?
}

class AgeViewModel : ObservableObject {
    @Published var person : Person = Person(count: nil, name: nil, age: 0)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.agify.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Person.self, from: data)
                DispatchQueue.main.async {
                    self.person = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct GuessAgeView: View {
    @StateObject var ageViewModel = AgeViewModel()
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
            VStack(spacing: 100) {
                VStack {
                    VStack(spacing: -10) {
                        Text("Your Age Is:")
                            .padding()
                            .font(.system(size: 50, weight: .thin))
                        if let ages = ageViewModel.person.age {
                            Text("\(ages)")
                                .padding()
                                .font(.system(size: 50, weight: .bold))
                        } else {
                            Text("NaN")
                                .padding()
                                .font(.system(size: 35, weight: .bold))
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationTitle("GUESS AGE")
                    .navigationBarTitleDisplayMode(.inline)
                    HStack(spacing: -30) {
                        Text("Total count: ")
                            .padding()
                            .font(.system(size: 20, weight: .light))
                        if let counts = ageViewModel.person.count {
                            Text("\(counts)")
                                .padding()
                                .font(.system(size: 20, weight: .light))
                        }
                        
                    }
                }
                
                
                
                VStack(spacing: 50) {
                    
                    VStack {
                        
                        TextField("Insert name here...", text:$ageViewModel.name)
                        
                        .overlay(
                            Text("")
                                .scaleEffect(0.8)
                                .foregroundColor(Color.black)
                                .opacity(0.5)
                        )
                        
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(15)
                            .frame(width: 300, height: 50)
                    }
                   
                    VStack(spacing: 20) {
                        Button(action: {
                            ageViewModel.fetchData()
                        },
                               label: {
                            Text("Guess the age")
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
        
    }


struct GuessAgeApi_Previews: PreviewProvider {
    static var previews: some View {
        GuessAgeView()
    }
}

