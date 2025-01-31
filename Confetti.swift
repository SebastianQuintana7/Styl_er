//
//  Confetti.swift
//  Styl_er MVP
//
//  Created by Jhonny Quintana on 31/1/2025.
//// MARK: - Confetti View (Fix for 'Cannot find ConfettiView in scope' error)

import SwiftUICore
struct ConfettiView: View {
    var body: some View {
        VStack {
            Text("🎉🎊")
                .font(.system(size: 100))
                .opacity(0.8)
                .transition(.scale)
        }
    }
}


