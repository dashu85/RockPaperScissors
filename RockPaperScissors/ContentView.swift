//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Marcus Benoit on 18.03.24.
//

import SwiftUI

struct ContentView: View {
    private let rockPaperScissors = ["🪨", "📄", "✂️"]
    
    @State private var winOrLose = false
    @State private var roundNumber: Int = 1
    
    @State private var score = 0
    @State private var cycleCount = 0
    
    @State var chosenByOpponent = Int.random(in: 0...2)
    @State private var answerText = ""
    @State private var finalMessage = ""
    @State private var showingFinalResult = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.green, .yellow, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text (
                        """
                        Do you know
                        how to play
                        Rock, Paper, Scissors?
                        """
                )
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("\(cycleCount)")
                
                Spacer()
                
                Text(winOrLose ? "How to beat" : "You have to lose to")
                    .font(.title.bold())
                
                HStack(spacing: 40) {
                    ZStack {
                        Text("\(rockPaperScissors[chosenByOpponent])")
                            .grayBackground()
                    }
                    
                }
                
                Spacer()
                
                Text("What do you choose?")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                HStack {
                    ForEach(0..<rockPaperScissors.count, id: \.self) { answer in
                        Button {
                            answerText = itemTapped(number: answer)
                            answerGiven()
                        } label: {
                            Text("\(rockPaperScissors[answer])")
                                .grayBackground()
                        }
                    }
                }
                
                Text("\(answerText)")
                
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
        }
        .alert("Hallo", isPresented: $showingFinalResult) {
            Button("Let's play again!", action: resetGame)
        } message: {
            Text("\(finalMessage)")
        }
    }
    
    
    func itemTapped(number: Int) -> String {
        var answer: String = rockPaperScissors[number]
        var answerTextInFunc: String = ""
        
        if winOrLose == true {
            if rockPaperScissors[chosenByOpponent] == "🪨" && answer == "📄" || rockPaperScissors[chosenByOpponent] == "📄" && answer == "✂️" || rockPaperScissors[chosenByOpponent] == "✂️" && answer == "🪨" {
                answerTextInFunc = "Correct"
                score += 1
                cycleCount += 1
                if cycleCount == 10 {
                    showingFinalResult = true
                }
                return answerTextInFunc
            }
        } else if winOrLose == false {
            if rockPaperScissors[chosenByOpponent] == "🪨" && answer == "✂️" || rockPaperScissors[chosenByOpponent] == "📄" && answer == "🪨" || rockPaperScissors[chosenByOpponent] == "✂️" && answer == "📄" {
                answerTextInFunc = "Correct"
                score += 1
                cycleCount += 1
                if cycleCount == 10 {
                    showingFinalResult = true
                }
                return answerTextInFunc
            } else {
                answerText = "FALSE :("
                score -= 1
                cycleCount += 1
                if cycleCount == 10 {
                    showingFinalResult = true
                }
                return answerText
            }
        }
        return answerText
    }
    
    func answerGiven() {
        chosenByOpponent = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        answerText = ""
        cycleCount = 0
    }
}

struct GrayBackground: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .opacity(0.6)
                }
                .font(.largeTitle)
        }
    }

// for a simpler implementation we can create a View extension to just call .BVBModifier
extension View {
        func grayBackground() -> some View {
            modifier(GrayBackground())
        }
    }


#Preview {
    ContentView()
}
