//
//  JokeView.swift
//  project-sarah
//
//  Created by Sarah Tsabitah on 29/07/23.
//

import SwiftUI

struct Jokes: Hashable, Codable {
    let type: String
    let setup: String?
    let punchline: String?
    let id: Int?
}

class JokeViewModel : ObservableObject {
    @Published var jokes: Jokes = Jokes(type: "general", setup: "Welcome To Jokes Generator", punchline: "Press the button below to generate", id: nil)
    
    func fetchData() {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONDecoder().decode(Jokes.self, from: data)
                DispatchQueue.main.async {
                    self.jokes = response
                }
            } catch {
                print("Unexpected error occured: \(error)")
            }
        }
        dataTask.resume()

    }
}


struct JokeView: View {
    @StateObject var jokeViewModel = JokeViewModel()
    
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
            VStack(spacing: 75) {
                VStack {
                    ZStack {
                        ZStack{
                            Rectangle()
                                .frame(width: 300, height: 400)
                                .foregroundColor(Color.purple)
                                .cornerRadius(70)
                                .shadow(radius: 10)
                            VStack(spacing: -75) {
                                if let jokess = jokeViewModel.jokes.setup, let punch = jokeViewModel.jokes.punchline {
                                    Text("\(jokess)")
                                        .multilineTextAlignment(.center)
                                        .frame(width: 250, height: 200)
    //                                    .background(Color.black)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25))
                                        .padding()
                                    Text("\(punch)")
                                        .multilineTextAlignment(.center)
    //                                    .background(Color.black)
                                        .frame(width: 250, height: 200)
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25, weight: .bold))
                                } else {
                                    Text("Do you know what's worse than writing HTML?")
                                        .multilineTextAlignment(.center)
                                        .frame(width: 250, height: 200)
    //                                    .background(Color.black)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25))
                                        .padding()
                                    Text("Ran out of jokes 🤣")
                                        .multilineTextAlignment(.center)
    //                                    .background(Color.black)
                                        .frame(width: 250, height: 200)
                                        .padding()
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 25, weight: .bold))
                                }
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationTitle("JOKES")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        ZStack{
                            VStack{
                                if let ids = jokeViewModel.jokes.id {
                                    Text("#\(ids)")
                                        .offset(y: -220)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 25, weight: .bold))
                                } else {
                                    Text("😆")
                                        .offset(y: -220)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 150, weight: .bold))
                                }
                                
                            }
                        }
                    }
                }
                
                VStack(spacing: 15) {
                    Button(action: {
                        jokeViewModel.fetchData()
                    },
                           label: {
                        Text("Generate Jokes")
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


struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}


