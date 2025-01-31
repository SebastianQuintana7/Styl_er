//
//  SettingsView.swift
//  Styl_er MVP
//
//  Created by Jhonny Quintana on 31/1/2025.
//
import SwiftUICore
struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings Page")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Customize your preferences here.")
                .font(.body)
                .foregroundColor(.gray)
                .padding()

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}


