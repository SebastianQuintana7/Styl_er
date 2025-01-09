//
//  StatCard.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 23/12/2024.
//

import SwiftUI

struct StatsCard: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(Color.orange.opacity(0.3))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

