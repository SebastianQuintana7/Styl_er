//
//  CartView.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 23/12/2024.
//

import SwiftUICore
import SwiftUI

struct CartView: View {
    @Binding var cartItems: [Outfit] // Array of outfits added to the cart

    var body: some View {
        VStack {
            // Title
            Text("Your Cart")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            if cartItems.isEmpty {
                // Empty State Message
                Text("Your cart is empty.")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Cart Items List
                ScrollView {
                    ForEach(cartItems) { item in
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.description)
                                    .font(.headline)
                                Text(item.price)
                                    .font(.subheadline)
                                    .foregroundColor(.orange)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
            }

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
