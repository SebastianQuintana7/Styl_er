//
//  TakePhotosView.swift
//  StyleSeeker 1.4
//
//  Created by Jhonny Quintana on 22/12/2024.
//
import SwiftUI
import AVFoundation

struct TakePhotoView: View {
    @State private var isPhotoTaken = false
    @State private var capturedImage: UIImage? = nil
    @State private var isProcessing = false
    @State private var progress: CGFloat = 0.0
    @State private var showRecommendations = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Camera Preview
                CameraView(capturedImage: $capturedImage, isPhotoTaken: $isPhotoTaken)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Capture Button
                    Button(action: {
                        isPhotoTaken = true
                        startProcessing()
                    }) {
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 4)
                            )
                    }
                    .padding(.bottom, 20)
                    .disabled(isProcessing)
                }
                
                // Processing Overlay
                if isProcessing {
                    VStack {
                        CircularProgress(progress: $progress)
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 10)
                        
                        Text("Processing your photo...")
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
                    destination: RecommendationsView(source: "Photo", input: "Captured Photo"),
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
                progress += 0.05
            }
        }
    }
}

// Circular Progress Indicator
struct CircularProgress: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.orange, lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.2), value: progress)
            
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

// Camera View (Placeholder Implementation)
struct CameraView: UIViewControllerRepresentable {
    @Binding var capturedImage: UIImage?
    @Binding var isPhotoTaken: Bool
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        // Placeholder camera view logic
        viewController.view.backgroundColor = .black
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

struct TakePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        TakePhotoView()
    }
}

