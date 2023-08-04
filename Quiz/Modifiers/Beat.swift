//
//  Beat.swift
//  Quiz
//
//  Created by Gustavo Binder on 03/08/23.
//

import SwiftUI

struct Beat: ViewModifier {
    @State var isBeating : Bool = true
    var size : CGFloat
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isBeating ? CGSize(width: 1, height: 1) : CGSize(width: size, height: size))
            .onAppear {
                withAnimation {
                    isBeating = !isBeating
                }
            }
            .onChange(of: isBeating) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation {
                        isBeating = !isBeating
                    }
                }
            }
    }
}

extension View {
    func beat(to size: CGFloat) -> some View {
        modifier(Beat(size: size))
    }
}
