//
//  GetStarted.swift
//  Styl_er MVP
//
//  Created by Jhonny Quintana on 31/1/2025.
//
import SwiftUI

struct Questionnaire: View {
    @State private var step: Int = 1
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var favoriteColors: String = ""
    @State private var clothingPreference: String = ""
    @State private var showConfetti = false
    @State private var navigateToPrompts = true

    let clothingOptions = ["Casual", "Formal", "Sporty", "Trendy"]
    
    var body: some View {
        NavigationStack {
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
                    OnboardingProgressBar(progress: CGFloat(step) / 5)
                        .frame(height: 8)
                        .padding(.horizontal)

                    Text("Let's get to know you!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()

                    // Dynamic Steps
                    if step == 1 {
                        QuestionnaireTextInput(question: "What's your name?", answer: $name)
                    } else if step == 2 {
                        QuestionnaireTextInput(question: "How old are you?", answer: $age)
                    } else if step == 3 {
                        QuestionnaireGenderPicker(gender: $gender)
                    } else if step == 4 {
                        QuestionnaireTextInput(question: "What are your favorite colors?", answer: $favoriteColors)
                    } else if step == 5 {
                        MultipleSelectionQuestion(
                            question: "What type of clothes do you like to wear?",
                            options: clothingOptions,
                            selectedOptions: $clothingPreference
                        )
                    }

                    Spacer()

                    // Next Button
                    if step < 5 {
                        Button(action: { step += 1 }) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .disabled(isCurrentStepInvalid())
                    } else {
                        NavigationLink(value: "WritePrompts") {
                            Text("Finish")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                        .disabled(isCurrentStepInvalid())
                    }
                }
                .padding()
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "WritePrompts" {
                    WritePromptsView()
                }
            }
        }
    }

    // MARK: - Step Background Colors
    private func stepBackgroundColors() -> [Color] {
        switch step {
        case 1: return [Color.blue, Color.purple]
        case 2: return [Color.orange, Color.red]
        case 3: return [Color.green, Color.yellow]
        case 4: return [Color.teal, Color.blue]
        case 5: return [Color.pink, Color.orange]
        default: return [Color.gray, Color.black]
        }
    }

    // MARK: - Input Validation
    private func isCurrentStepInvalid() -> Bool {
        switch step {
        case 1: return name.isEmpty
        case 2: return age.isEmpty
        case 3: return gender.isEmpty
        case 4: return favoriteColors.isEmpty
        case 5: return clothingPreference.isEmpty
        default: return false
        }
    }
}

// MARK: - Components

/// Text input for name, age, and favorite colors
struct QuestionnaireTextInput: View {
    var question: String
    @Binding var answer: String

    var body: some View {
        VStack(spacing: 20) {
            Text(question)
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            TextField("Type your answer here...", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
        .padding(.horizontal, 20)
    }
}

/// Gender Picker
struct QuestionnaireGenderPicker: View {
    @Binding var gender: String

    var body: some View {
        VStack(spacing: 20) {
            Text("What's your gender?")
                .font(.title2)
                .foregroundColor(.white)

            Picker("Gender", selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Other").tag("Other")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .padding(.horizontal, 20)
    }
}

/// Multi-selection for clothing preferences
struct MultipleSelectionQuestion: View {
    var question: String
    var options: [String]
    @Binding var selectedOptions: String

    var body: some View {
        VStack(spacing: 20) {
            Text(question)
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    Image(systemName: selectedOptions.contains(option) ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(selectedOptions.contains(option) ? .orange : .white)
                        .onTapGesture {
                            toggleSelection(option)
                        }
                }
                .padding(.horizontal, 20)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
            }
        }
        .padding(.horizontal, 20)
    }

    private func toggleSelection(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions = selectedOptions.replacingOccurrences(of: option, with: "").trimmingCharacters(in: .whitespaces)
        } else {
            selectedOptions += (selectedOptions.isEmpty ? "" : ", ") + option
        }
    }
}

// MARK: - Progress Bar
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

// MARK: - Placeholder WritePromptsView
struct WritePrompts: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.pink]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            Text("Write your style prompts here!")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview
struct Questionaire_Previews: PreviewProvider {
    static var previews: some View {
        Questionnaire()
    }
}

