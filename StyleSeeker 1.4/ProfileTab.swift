//
//  ProfileTab.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 23/12/2024.
//
import SwiftUI

struct ProfileTab: View {
    @State private var profileName: String = "Sebastian"
    @State private var styleAvatar: String = "😁" // Style avatar placeholder
    @State private var outfitsSaved: Int = 15
    @State private var stylePoints: Int = 320
    @State private var currentLevel: Int = 3
    @State private var currentXP: CGFloat = 0.6 // Progress towards the next level
    @State private var xpRequired: Int = 500 // XP needed for next level
    @State private var showSettings = false
    @State private var savedOutfits: [String] = ["Casual Look", "Party Dress", "Summer Vibes"]
    @State private var dailyChallenge: String = "Save 3 outfits today"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Top Section: User Info and Stats
                    TopProfileSection(
                        profileName: $profileName,
                        styleAvatar: $styleAvatar,
                        outfitsSaved: outfitsSaved,
                        stylePoints: stylePoints,
                        currentLevel: $currentLevel,
                        currentXP: $currentXP
                    )

                    // Saved Outfits Section
                    SavedOutfitsSection(savedOutfits: savedOutfits)

                    // Challenges and Rewards Section
                    ChallengesAndRewardsSection(
                        dailyChallenge: dailyChallenge,
                        xpRequired: xpRequired
                    )
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showSettings = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .sheet(isPresented: $showSettings) {
                SettingsView() // Placeholder for settings
            }
        }
    }
}

// MARK: - Top Section
struct TopProfileSection: View {
    @Binding var profileName: String
    @Binding var styleAvatar: String
    let outfitsSaved: Int
    let stylePoints: Int
    @Binding var currentLevel: Int
    @Binding var currentXP: CGFloat

    var body: some View {
        VStack(spacing: 15) {
            // Style Avatar
            Text(styleAvatar)
                .font(.system(size: 80))

            // Profile Name
            TextField("Enter your name", text: $profileName)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)

            // Level and XP Bar
            VStack {
                Text("Level \(currentLevel)")
                    .font(.headline)
                    .foregroundColor(.white)

                ProgressBar(progress: $currentXP)
                    .frame(height: 10)
                    .padding(.horizontal, 20)
            }

            // Quick Stats
            HStack(spacing: 40) {
                StatCard(label: "Outfits", value: "\(outfitsSaved)")
                StatCard(label: "Style Points", value: "\(stylePoints)")
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

// MARK: - Progress Bar
struct ProgresBar: View {
    @Binding var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: geometry.size.width, height: geometry.size.height)

                Capsule()
                    .fill(Color.orange)
                    .frame(width: geometry.size.width * progress, height: geometry.size.height)
            }
        }
    }
}

// MARK: - Saved Outfits Section
struct SavedOutfitsSection: View {
    let savedOutfits: [String]

    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Saved Outfits")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)

            // Horizontal Scroll View
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(savedOutfits, id: \.self) { outfit in
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Text(outfit)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                            )
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

// MARK: - Challenges and Rewards Section
struct ChallengesAndRewardsSection: View {
    let dailyChallenge: String
    let xpRequired: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Daily Challenge
            Text("Daily Challenge")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading)

            Text(dailyChallenge)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)

            // XP Rewards
            HStack {
                Text("XP Required for Next Level:")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                Text("\(xpRequired)")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

// MARK: - Stat Card
struct StatCard: View {
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

// MARK: - Placeholder Settings View
struct SettingView: View {
    var body: some View {
        VStack {
            Text("Settings Page Placeholder")
                .font(.title)
                .padding()
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Preview
struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}

