//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Günseli Ünsal on 21.06.2024.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊🏻", "🖐🏻", "✌🏻"]
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.orange]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Text("Computer has played...").font(.title3).foregroundStyle(.secondary).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(moves[computerChoice]).font(.system(size: 150)).background(.secondary).clipShape(Circle()).padding(20)
                    
                    HStack {
                        Text("You should:").foregroundStyle(.secondary).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        if shouldWin {
                            Text("WIN").foregroundStyle(.green).fontWeight(.bold).font(.title2)
                        } else {
                            Text("LOSE").foregroundStyle(.red).fontWeight(.bold).font(.title2)
                        }
                    }.padding(.bottom, 30)
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button(action: {
                                play(choice: number)
                            }, label: {
                                Text(moves[number]).font(.system(size: 90))
                            }).background(.secondary).clipShape(Circle())
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Score: \(score)").font(.title3).padding().foregroundStyle(.secondary).fontWeight(.bold)
                        Text("Question: \(questionCount)").font(.title3).foregroundStyle(.secondary).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
                .alert("GAME OVER!", isPresented: $showingResults) {
                    Button("Restart Game", action: reset)
                } message: {
                    Text("Your score is: \(score)")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: reset) {
                            Image(systemName: "arrow.counterclockwise").foregroundStyle(.black)
                        }
                    }
                }
                .navigationTitle("Rock Paper Scissor 👾")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func play(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        
        if didWin {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCount == 10 {
            showingResults = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
    }
    
    func reset() {
        score = 0
        questionCount = 1
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
