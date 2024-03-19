//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Marcus Benoit on 18.03.24.
//




import SwiftUI

struct ContentView: View {
    private let rockPaperScissors = ["🪨", "📄", "✂️"]
    private let winRockPaperScissors = [1, 2, 0]
    
    @State private var winOrLose: Bool = Bool.random()
    
    @State private var score = 0
    @State private var cycleCount = 0
    @State private var maxNumberOfGames = 10
    
    @State var chosenByComputer = Int.random(in: 0...2)
    @State private var answerText = ""
    @State private var finalMessage = ""
    @State private var showingFinalResult = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
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
                
                Text("Round \(cycleCount + 1) of 10")
                
                Spacer()
                
                Text(winOrLose ? "You have to beat" : "You have to lose to")
                    .font(.title.bold())
                
                HStack(spacing: 40) {
                    ZStack {
                        Text("\(rockPaperScissors[chosenByComputer])")
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
                            print("tapped Item: \(answer)")
                            tappedOnItem(answer)
                            winOrLose.toggle()
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
        .alert("Your final score is \(score)", isPresented: $showingFinalResult) {
            Button("Let's play again!", action: resetGame)
        } message: {
            Text("\(finalMessage)")
        }
    }
    
    func didUserWin(_ number: Int) -> String {
        let winningAnswer = winRockPaperScissors[chosenByComputer]
        
        print("winningAnswer: \(winningAnswer)")
    
        var didWin: Bool
        
        if winOrLose {
            didWin = rockPaperScissors[winningAnswer] == rockPaperScissors[number]
        } else {
            didWin = rockPaperScissors[winningAnswer] != rockPaperScissors[number]
        }
        
        if rockPaperScissors[chosenByComputer] == rockPaperScissors[number] { didWin = false }
        
        return didWin ? "Correct" : "Wrong"
    }
    
    func tappedOnItem(_ byPlayer: Int) {
        
        answerText = didUserWin(byPlayer)
        
        score = answerText == "Correct" ? score + 1 : score - 1
        
        chosenByComputer = Int.random(in: 0...2)

        
        if cycleCount == 9 {
            showingFinalResult = true
        } else {
            cycleCount += 1
        }
    }
    
    func resetGame() {
        score = 0
        answerText = " "
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
                .font(.system(size: 70))
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
