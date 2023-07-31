//
//  GuessGenderView.swift
//  project-sarah
//
//  Created by Sarah Tsabitah on 29/07/23.
//

import Foundation
import SwiftUI

struct Persons: Hashable, Codable {
    let count: Int
    let name: String
    let gender: String?
    let probability: Double?
}

class GenderViewModel : ObservableObject {
    @Published var persons : Persons = Persons(count: 0, name: "", gender: "", probability: nil)
    
    @Published var name = ""
    
    func fetchData() {
        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Persons.self, from: data)
                DispatchQueue.main.async {
                    self.persons = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct GuessGenderView: View {
    @StateObject var genderViewModel = GenderViewModel()
    
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
            VStack(spacing: 50) {
                VStack {
                    VStack(spacing: -10) {
                        Text("Your Gender Is:")
                            .padding()
                            .font(.system(size: 50, weight: .thin))
                            .navigationBarBackButtonHidden(true)
                            .navigationTitle("GUESS GENDER")
                            .navigationBarTitleDisplayMode(.inline)
                        
                        if let genders = genderViewModel.persons.gender {
                            Text("\(genders.uppercased())")
                                .padding()
                                .font(.system(size: 50, weight: .bold))
                        } else {
                            Text("NaN")
                                .padding()
                                .font(.system(size: 50, weight: .bold))
                        }
                    }
                    
                }
                HStack(spacing: -30) {
                    Text("Status: ")
                        .padding()
                        .font(.system(size: 20, weight: .light))
                    if genderViewModel.persons.probability == 1.000000 {
                        Text("Your gender 100% certain")
                            .padding()
                            .font(.system(size: 20, weight: .light))
                    } else if genderViewModel.persons.probability == nil{
                        Text("")
                            .padding()
                            .font(.system(size: 20, weight: .light))
                    } else {
                        Text("Your gender less than 100% certain")
                            .padding()
                            .font(.system(size: 20, weight: .light))
                    }
                    
                }
                
                
                TextField("Insert the name here", text: $genderViewModel.name)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    .frame(width: 300, height: 50)
                
                VStack(spacing: 15) {
                    Button(action: {
                        genderViewModel.fetchData()
                    },
                           label: {
                        Text("Show your gender")
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


struct GuessGender_Previews: PreviewProvider {
    static var previews: some View {
        GuessGenderView()
    }
}

