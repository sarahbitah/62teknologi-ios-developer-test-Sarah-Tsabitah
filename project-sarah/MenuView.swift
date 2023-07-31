//
//  MenuView.swift
//  project-sarah
//
//  Created by Sarah Tsabitah on 29/07/23.
//

import Foundation
import SwiftUI

struct MenuView : View {
    private var data:  [Int] = Array(1...6)
    private let colors: [Color] = [.red, .yellow, .blue, .green]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    
    
    var body : some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 25) {
                    
                    NavigationLink(destination: JokeView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.accentColor)
                                .cornerRadius(50)
                            VStack{
                                Text("Jokes 😆")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                    
                    NavigationLink(destination: CatFactView(), label:{
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.pink)
                                .cornerRadius(50)
                            VStack{
                                Text("Cat Fact 🐱")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                    
                    NavigationLink(destination: DogieView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.cyan)
                                .cornerRadius(50)
                            VStack{
                                Text("Dogs")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                Text("Random     🐶")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                        
                    
                    NavigationLink(destination: GuessAgeView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.indigo)
                                .cornerRadius(50)
                            VStack{
                                Text("Guess Age 👤")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                    
                    
                    NavigationLink(destination: GuessGenderView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.teal)
                                .cornerRadius(50)
                            VStack{
                                Text("Guess")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                Text(" Gender        👱🏻‍♀️👱🏻")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                        
                    NavigationLink(destination: IpInfoView(), label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(Color.purple)
                                .cornerRadius(50)
                            VStack{
                                Text("Ip Info 📩")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                            }
                        }
                    })
                }
            }
            .padding()
            .navigationTitle("Main Menu")
            .navigationBarBackButtonHidden()
        }
    }
}


struct MainRootView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
