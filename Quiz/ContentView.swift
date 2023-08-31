//
//  ContentView.swift
//  Quiz
//
//  Created by Gustavo Binder on 31/07/23.
//

import SwiftUI
import GameKit

struct ContentView: View {
    
    @Namespace var namespace
    @EnvironmentObject var gcmanager : GCManager
    @EnvironmentObject var sceneManager : SceneManager
    
    @Binding var points : Int
    @State var index : Int = 0
    
    @State var pressed : Bool = false
    @State var gotRight : Bool = false
    @State var buttonPressed : Int = -1
    
    @State var localQuestions = questions.shuffled()
    
    @State var transit = false
    
    @State var monkeyState : Mood = .normal
    
    let localPlayer = GKLocalPlayer.local
    
    private func toNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.spring()) {
                transit = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                withAnimation {
                    if index < localQuestions.count - 1 {
                        index += 1
                        localQuestions[index].options.shuffle()
                        pressed = false
                        transit = false
                        buttonPressed = -1
                        monkeyState = .normal
                    } else {
                        sceneManager.currentScene = .end
//                        gcmanager.submitScore(score: points)
                    }
                    gotRight = false
                }
            }
        }
    }
    
    var body: some View {
        
        let QAUX = localQuestions[index]
        
        VStack {
            HStack {
                HStack {
                    Text("Points: \(points)")
                        .frame(height: 10)
                        .foregroundColor(.white)
                    if pressed {
                        Text(gotRight ? "+10" : "-10")
                            .font(.largeTitle)
                            .foregroundColor(gotRight ? .green : .red)
                            .frame(height: 10)
                            .transition(.scale)
                    }
                }
                .padding()
                .background {
                    Color.black
                        .cornerRadius(8)
                }
                Spacer()
                
                Button {
                    withAnimation {
                        sceneManager.currentScene = .menu
                    }
                } label: {
                    Image(systemName: "house.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 40, height: 40)
                        .padding(8)
                        .background {
                            Color.accentColor
                                .cornerRadius(60)
                        }
                }
            }
            Spacer()
            if !transit {
                Text(QAUX.question)
                    .transition(.scale)
                    .padding()
                    .background {
                        Color.black
                            .cornerRadius(8)
                    }
                    .foregroundColor(.white)
                    .padding()
                
                switch (monkeyState) {
                case .normal:
                    Image("NormalMonkey")
                case .happy:
                    Image("HappyMonkey")
                        .wiggle(true, 15, 0.2)
                case .sad:
                    Image("SadMonkey")
                }
                
                ForEach(Range(0...QAUX.options.count - 1), id: \.self) { i in
                    Button {
                        if pressed { return }
                        
                        if QAUX.options[i].1 {
                            points += 10
                            gotRight = true
                            monkeyState = .happy
                        } else {
                            points -= 10
                            monkeyState = .sad
                        }
                        
                        buttonPressed = i
                        
                        withAnimation {
                            pressed = true
                        }
                        
                        toNextQuestion()
                        
                    } label: {
                        Text(QAUX.options[i].0)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background {
                                if pressed {
                                    if QAUX.options[i].1
                                    {
                                        Color.green
                                    } else {
                                        if buttonPressed == i {
                                            Color.red
                                        } else {
                                            Color.black
                                                .opacity(0.5)
                                                .border(.black)
                                        }
                                    }
                                } else {
                                    Color.black
                                        .opacity(0.5)
                                        .border(.black)
                                }
                            }
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .beat(to: QAUX.options[i].1 == true && pressed ? CGSize(width: 0.85, height: 0.85) : CGSize(width: 1, height: 1))
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            points = 0
        }
    }
}
