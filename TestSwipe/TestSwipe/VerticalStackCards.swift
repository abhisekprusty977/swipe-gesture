//
//  VerticalStackCards.swift
//  TestSwipe
//
//  Created by Abhisek Prusty on 19/04/26.
//

import SwiftUI

struct CenterCarouselView: View {
    
    let items = ["ImageOne", "ImageTwo", "ImageThree", "ImageFour"]
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geo in
            
            let cardWidth = geo.size.width * 0.7
            let spacing: CGFloat = 16
            
            HStack(spacing: spacing) {
                
                ForEach(items.indices, id: \.self) { index in
                    
                    Image(items[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: 420)
                        .cornerRadius(20)
                        .shadow(radius: 6)
                        
                        // 🔥 CENTER SCALE EFFECT
                        .scaleEffect(index == currentIndex ? 1 : 0.88)
                        
                        // 🔥 SMOOTH TRANSITION SCALE (while dragging)
                        .scaleEffect(
                            1 - abs(CGFloat(index - currentIndex) * 0.05)
                        )
                }
            }
            
            // 🔥 CENTER ALIGNMENT
            .padding(.horizontal, (geo.size.width - cardWidth) / 2)
            
            // 🔥 MOVE CARDS FULL WIDTH
            .offset(
                x: -CGFloat(currentIndex) * (cardWidth + spacing) + dragOffset
            )
            
            // 🔥 DRAG GESTURE
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        
                        let threshold: CGFloat = 80
                        
                        if value.translation.width < -threshold {
                            currentIndex = min(currentIndex + 1, items.count - 1)
                        }
                        else if value.translation.width > threshold {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    }
            )
            
            // 🔥 SPRING ANIMATION (LinkedIn style smooth)
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: currentIndex)
        }
    }
}

#Preview {
    CenterCarouselView()
}
