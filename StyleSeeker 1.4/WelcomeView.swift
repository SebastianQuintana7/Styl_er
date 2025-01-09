//
//  Untitled.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 22/12/2024.
//import SwiftUI

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        TabView {
            // Home Tab
            VStack {
                WelcomeContent()
            }
            .tabItem {
                VStack {
                    Image(systemName: "house")
                        .font(.system(size: 24, weight: .bold)) // Home icon
                    Text("Home")
                }
            }
            
            // Take Photo Tab
            TakePhotoView()
                .tabItem {
                    VStack {
                        Image(systemName: "camera.aperture")
                            .font(.system(size: 24, weight: .bold)) // Camera icon
                        Text("Take Photo")
                    }
                }
            
            // Write Prompt Tab
            WritePromptsView()
                .tabItem {
                    VStack {
                        Image(systemName: "pencil")
                            .font(.system(size: 24, weight: .bold)) // Pencil icon
                        Text("Write Prompt")
                    }
                }
            
            // Profile Tab
            ProfileTab()
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 24, weight: .bold)) // Profile icon
                        Text("Profile")
                    }
                }
        }
        .accentColor(.orange) // Highlight color for selected tab
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
}

struct WelcomeContent: View {
    var body: some View {
        ZStack {
            // Vibrant background
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                // T-shirt logo with animation
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
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                // Brief description
                Text("Explore the latest trends and customize your wardrobe effortlessly. StyleSeeker helps you find and create outfits that match your unique taste.")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                // Get Started Button
                NavigationLink(destination: OnboardingView()) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Onboarding View
struct OnboardingView: View {
    @State private var step: Int = 1
    @State private var clothingPreference: String = ""
    @State private var season: String = ""
    @State private var colorPalette: String = ""

    var body: some View {
        VStack(spacing: 30) {
            Text("Tell us about your style!")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            if step == 1 {
                VStack {
                    Text("What type of clothing are you most interested in?")
                        .font(.headline)
                        .padding(.bottom)

                    Picker("Clothing Preference", selection: $clothingPreference) {
                        Text("Casual").tag("Casual")
                        Text("Formal").tag("Formal")
                        Text("Sporty").tag("Sporty")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            } else if step == 2 {
                VStack {
                    Text("Which season are you shopping for?")
                        .font(.headline)
                        .padding(.bottom)

                    Picker("Season", selection: $season) {
                        Text("Spring").tag("Spring")
                        Text("Summer").tag("Summer")
                        Text("Fall").tag("Fall")
                        Text("Winter").tag("Winter")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            } else if step == 3 {
                VStack {
                    Text("What is your preferred color palette?")
                        .font(.headline)
                        .padding(.bottom)

                    TextField("Enter colors (e.g., Blue, Black)", text: $colorPalette)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }

            Spacer()

            Button(action: {
                if step < 3 {
                    step += 1
                } else {
                    savePreferences()
                }
            }) {
                Text(step < 3 ? "Next" : "Finish")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }

    func savePreferences() {
        print("Preferences Saved:")
        print("Clothing Preference: \(clothingPreference)")
        print("Season: \(season)")
        print("Color Palette: \(colorPalette)")
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
