//
//  GetStarted.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 28/12/2024.
//

import SwiftUI

struct GetStartedView: View {
    @State private var step: Int = 1
    @State private var clothingPreference: String = ""
    @State private var season: String = ""
    @State private var colorPalette: String = ""
    @State private var stylePoints: Int = 0
    @State private var showConfetti = false

    var body: some View {
        ZStack {
            // Dynamic Background
            LinearGradient(
                gradient: Gradient(colors: stepBackgroundColors()),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            .animation(.easeInOut, value: step)

            VStack(spacing: 30) {
                // Progress Indicator
                OnboardingProgressBar(progress: CGFloat(step) / 3)
                    .frame(height: 8)
                    .padding(.horizontal)

                Text("StyleSeeker Onboarding")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                // Dynamic Steps
                if step == 1 {
                    clothingPreferenceSection()
                } else if step == 2 {
                    seasonPreferenceSection()
                } else if step == 3 {
                    colorPaletteSection()
                }

                Spacer()

                // Next Button
                Button(action: nextStep) {
                    Text(step < 3 ? "Next" : "Finish")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .overlay(
                showConfetti ? ConfettiView() : nil
            )
        }
    }

    // MARK: - Sections
    @ViewBuilder
    private func clothingPreferenceSection() -> some View {
        VStack {
            Text("What type of clothing are you most interested in?")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom)

            Picker("Clothing Preference", selection: $clothingPreference) {
                Text("Casual").tag("Casual")
                Text("Formal").tag("Formal")
                Text("Sporty").tag("Sporty")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if !clothingPreference.isEmpty {
                Image("\(clothingPreference.lowercased())_preview")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    .transition(.scale)
            }
        }
    }

    @ViewBuilder
    private func seasonPreferenceSection() -> some View {
        VStack {
            Text("Which season are you shopping for?")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom)

            Picker("Season", selection: $season) {
                Text("Spring").tag("Spring")
                Text("Summer").tag("Summer")
                Text("Fall").tag("Fall")
                Text("Winter").tag("Winter")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if !season.isEmpty {
                Text("Season: \(season)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .animation(.easeInOut)
            }
        }
    }

    @ViewBuilder
    private func colorPaletteSection() -> some View {
        VStack {
            Text("What is your preferred color palette?")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom)

            TextField("Enter colors (e.g., Blue, Black)", text: $colorPalette)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if !colorPalette.isEmpty {
                Text("Preview: \(colorPalette)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .animation(.easeInOut)
            }
        }
    }

    // MARK: - Step Background Colors
    private func stepBackgroundColors() -> [Color] {
        switch step {
        case 1: return [Color.blue, Color.purple]
        case 2: return [Color.orange, Color.red]
        case 3: return [Color.green, Color.yellow]
        default: return [Color.gray, Color.black]
        }
    }

    // MARK: - Next Step
    private func nextStep() {
        if step < 3 {
            step += 1
        } else {
            stylePoints += 50
            showConfetti = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showConfetti = false
            }
        }
    }
}

// MARK: - Onboarding Progress Bar
struct OnboardingProgressBar: View {
    var progress: CGFloat

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

// MARK: - Confetti View
struct ConfettiView: View {
    var body: some View {
        Text("🎉🎊")
            .font(.system(size: 100))
            .opacity(0.8)
            .transition(.scale)
    }
}

// MARK: - Preview
struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
