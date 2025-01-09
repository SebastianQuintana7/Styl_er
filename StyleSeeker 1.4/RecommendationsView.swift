//
//  RecommendationsView.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 22/12/2024.
//

import SwiftUICore
import SwiftUI

struct RecommendationsView: View {
    var source: String // Either "Photo" or "Prompt"
    var input: String  // The photo filename or prompt text
    @State private var outfits: [Outfit] = []
    @State private var savedOutfits: [Outfit] = []
    @State private var cartItems: [Outfit] = []
    @State private var stylePoints: Int = 0
    @State private var selectedOutfit: Outfit? = nil
    @State private var showDetails = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Title
                    Text("Recommended Outfits")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    // Subtitle
                    Text("Based on your \(source): \(input)")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)

                    // Quick Stats: Style Points
                    HStack {
                        Text("Style Points: \(stylePoints)")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 20)

                    // Outfit List
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(outfits) { outfit in
                                OutfitCard(
                                    outfit: outfit,
                                    onSave: {
                                        saveOutfit(outfit)
                                    },
                                    onInfo: {
                                        selectedOutfit = outfit
                                        showDetails = true
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer()
                }
                .padding()
                .onAppear {
                    loadOutfits()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CartView(cartItems: $cartItems)) {
                            Image(systemName: "cart")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                }

                // Navigation to Details View
                if let selectedOutfit = selectedOutfit, showDetails {
                    DetailsView(outfit: selectedOutfit, cartItems: $cartItems, showDetails: $showDetails)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }

    // Simulated data loading function
    func loadOutfits() {
        outfits = [
            Outfit(id: 1, imageName: "outfit1", description: "Casual summer look", price: "$120", size: "M"),
            Outfit(id: 2, imageName: "outfit2", description: "Formal evening attire", price: "$250", size: "L"),
            Outfit(id: 3, imageName: "outfit3", description: "Cozy winter outfit", price: "$180", size: "S")
        ]
    }

    // Save outfit and reward style points
    func saveOutfit(_ outfit: Outfit) {
        if !savedOutfits.contains(where: { $0.id == outfit.id }) {
            savedOutfits.append(outfit)
            stylePoints += 20 // Add points for saving an outfit
        }
    }
}

// Card view for displaying an individual outfit
struct OutfitCard: View {
    let outfit: Outfit
    let onSave: () -> Void // Callback for saving an outfit
    let onInfo: () -> Void // Callback for viewing details

    var body: some View {
        HStack {
            Image(outfit.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {
                Text(outfit.description)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(outfit.price)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                HStack {
                    Button(action: onSave) {
                        Text("Save")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(5)
                    }

                    Button(action: onInfo) {
                        Image(systemName: "info.circle")
                            .font(.title2)
                            .foregroundColor(.orange)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(10)
    }
}

// Detailed view for an outfit
struct DetailsView: View {
    let outfit: Outfit
    @Binding var cartItems: [Outfit]
    @Binding var showDetails: Bool

    var body: some View {
        VStack {
            Image(outfit.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(10)
                .padding()

            Text(outfit.description)
                .font(.title)
                .fontWeight(.bold)
                .padding()

            HStack {
                Text("Price:")
                    .font(.headline)
                Text(outfit.price)
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            .padding()

            HStack {
                Text("Size:")
                    .font(.headline)
                Text(outfit.size)
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            .padding()

            Button(action: {
                cartItems.append(outfit)
                showDetails = false
            }) {
                Text("Add to Cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                showDetails = false
            }) {
                Text("Close")
                    .foregroundColor(.orange)
            }
            .padding(.top, 10)

            Spacer()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}

// Data model for outfits
struct Outfit: Identifiable {
    let id: Int
    let imageName: String
    let description: String
    let price: String
    let size: String
}

struct RecommendationsView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsView(source: "Prompt", input: "Casual summer outfit")
    }
}
