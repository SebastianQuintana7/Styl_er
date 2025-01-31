//
//  WritePrompts.swift
//  Styl_er MVP
//
//  Created by Jhonny Quintana on 31/1/2025.
//

import SwiftUI

struct WritePromptsView: View {
    @State private var prompt: String = ""
    @State private var generatedImage: UIImage? = nil
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    // OpenAI API Configuration
        private let apiKey = "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"
        private let dalleEndpoint = "https://api.openai.com/v1/images/generations"

    var body: some View {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("What are you looking for?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Text("Describe your style, outfit idea, or occasion.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 10)

                    Spacer()

                    TextField("Type your prompt here...", text: $prompt)
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

                    Button(action: generateImage) {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("Generate Image")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .disabled(isLoading || prompt.isEmpty)
                    .padding(.horizontal)

                    Spacer()

                    if let uiImage = generatedImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300, maxHeight: 300)
                            .cornerRadius(10)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxWidth: 300, maxHeight: 300)
                            .overlay(Text("Image will appear here").foregroundColor(.gray))
                    }

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Spacer()
                }
                .padding()
            }
        }

        private func generateImage() {
            guard !prompt.isEmpty else { return }
            isLoading = true
            errorMessage = nil

            guard let url = URL(string: dalleEndpoint) else {
                errorMessage = "Invalid API endpoint."
                isLoading = false
                return
            }

            let body: [String: Any] = [
                "prompt": prompt,
                "n": 1,
                "size": "1024x1024"
            ]

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                errorMessage = "Failed to encode request."
                isLoading = false
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    isLoading = false
                }

                if let error = error {
                    DispatchQueue.main.async {
                        errorMessage = "Error: \(error.localizedDescription)"
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        errorMessage = "No data received."
                    }
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let dataArray = json["data"] as? [[String: Any]],
                       let urlString = dataArray.first?["url"] as? String,
                       let imageUrl = URL(string: urlString) {
                        let imageData = try Data(contentsOf: imageUrl)
                        if let uiImage = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                generatedImage = uiImage
                            }
                        } else {
                            DispatchQueue.main.async {
                                errorMessage = "Failed to parse image."
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            errorMessage = "Invalid response from server."
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        errorMessage = "Error parsing response: \(error.localizedDescription)"
                    }
                }
            }.resume()
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


