//
//  Wiggle.swift
//  Quiz
//
//  Created by Gustavo Binder on 03/08/23.
//

import SwiftUI

struct Wiggle: ViewModifier {
    @State var isRotating : Bool
    var angle : Double
    var time : Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isRotating ? angle : -angle))
            .onAppear {
                withAnimation {
                    isRotating = !isRotating
                }
            }
            .onChange(of: isRotating) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    withAnimation {
                        isRotating = !isRotating
                    }
                }
            }
    }
}

extension View {
    func wiggle(_ left: Bool, _ angle: Double, _ time: Double) -> some View {
        modifier(Wiggle(isRotating: left, angle: angle, time: time))
    }
}
