//
//  SettingsView.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 23/12/2024.
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

