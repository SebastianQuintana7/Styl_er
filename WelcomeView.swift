//
//  WelcomeView.swift
//  Styl_er MVP
//
//  Created by Jhonny Quintana on 31/1/2025.
//

import SwiftUI

// MARK: - Welcome View with Bottom Navigation
struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            TabView {
                // Home Tab
                WelcomeContent()
                    .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }

                // Write Prompt Tab
                WritePromptsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "pencil")
                            Text("Write Prompt")
                        }
                    }

                // Profile Tab
                ProfileTab()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }
                    }
            }
            .accentColor(.orange) // Highlight color for selected tab
            .onAppear {
                UITabBar.appearance().backgroundColor = UIColor.white
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "Questionnaire" {
                    Questionnaire()
                }
            }
        }
    }
}

// MARK: - Welcome Content (Home Screen)
struct WelcomeContent: View {
    var body: some View {
        ZStack {
            // Vibrant background
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                // T-shirt logo
                Image(systemName: "tshirt")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)

                // Welcome message
                Text("Welcome to StyleSeeker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                // Slogan
                Text("Discover Your Style")
                    .font(.title2)
                    .foregroundColor(.white)

                // Brief description
                Text("Explore the latest trends and customize your wardrobe effortlessly. StyleSeeker helps you find and create outfits that match your unique taste.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                // Get Started Button (Navigates to the Questionnaire)
                NavigationLink("Get Started", value: "Questionnaire")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(.top, 30)

                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
