//
//  WritePrompts.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 22/12/2024.
//import SwiftUI

import SwiftUI

struct WritePromptsView: View {
    @State private var promptText: String = ""
    @State private var showRecommendations = false
    @State private var isProcessing = false
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Title
                    Text("What are you looking for?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    // Instruction Text
                    Text("Describe your style, outfit idea, or occasion.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    // Text Field for Prompt
                    TextField("Type your prompt here...", text: $promptText)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.2))
                        )
                        .foregroundColor(.white)
                        .accentColor(.orange)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Fetch Recommendations Button
                    Button(action: {
                        startProcessing()
                    }) {
                        Text(isProcessing ? "Processing..." : "Fetch Recommendations")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isProcessing ? Color.gray : Color.orange)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                    .disabled(isProcessing)
                }
                
                // Processing Overlay
                if isProcessing {
                    VStack {
                        ProgressBar(progress: $progress)
                            .frame(width: 200, height: 10)
                            .padding(.bottom, 10)
                        
                        Text("Processing your request...")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
                
                // Navigation Link
                NavigationLink(
                    destination: RecommendationsView(source: "Prompt", input: promptText),
                    isActive: $showRecommendations
                ) {
                    EmptyView()
                }
            }
        }
    }
    
    // Simulate Progress
    func startProcessing() {
        isProcessing = true
        progress = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if progress >= 1.0 {
                timer.invalidate()
                isProcessing = false
                showRecommendations = true
            } else {
                progress += 0.05 // Slower increment for a more deliberate feel
            }
        }
    }
}

// Custom ProgressBar
struct ProgressBar: View {
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

struct WritePromptsView_Previews: PreviewProvider {
    static var previews: some View {
        WritePromptsView()
    }
}


