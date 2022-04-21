//
//  LottieView.swift
//  Mit_Assi1_Animation
//
//  Created by user215540 on 3/27/22.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    @Binding var animationInProgress: Bool
    
    func makeUIView(context: Context) -> some AnimationView {
        let view = AnimationView(name: "cartanim")
        view.frame = CGRect(x: 0, y: 0, width:150, height: 200)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        view.play { complete in
            if complete {
                animationInProgress = true
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
