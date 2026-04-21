//
//  HorizontalStackedCards.swift
//  TestSwipe
//
//  Created by Abhisek Prusty on 19/04/26.
//

import SwiftUI

struct HorizontalStackedCards: View {
    
    let items = ["ImageOne", "ImageTwo", "ImageThree", "ImageFour"]
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geo in
            
            let cardWidth = geo.size.width * 0.75
            let spacing: CGFloat = 20
            
            HStack(spacing: spacing) {
                
                ForEach(items.indices, id: \.self) { index in
                    
                    Image(items[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: 420)
                        .cornerRadius(20)
                        .shadow(radius: 8)
                        
                        // 🔥 POSITION
                        .offset(x: CGFloat(index - currentIndex) * (cardWidth + spacing))
                        
                        // 🔥 PARALLAX
                        .offset(x: dragOffset)
                        
                        // 🔥 SCALE EFFECT
                        .scaleEffect(index == currentIndex ? 1 : 0.9)
                        
                        // 🔥 BLUR (optional)
                        .blur(radius: index == currentIndex ? 0 : 2)
                        
                        // 🔥 3D EFFECT
                        .rotation3DEffect(
                            .degrees(Double(dragOffset / -20)),
                            axis: (x: 0, y: 1, z: 0)
                        )
                }
            }
            .frame(width: geo.size.width, alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * (cardWidth + spacing))
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = 100
                        
                        if value.translation.width < -threshold {
                            currentIndex = min(currentIndex + 1, items.count - 1)
                        } else if value.translation.width > threshold {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    }
            )
            .animation(.spring(response: 0.4, dampingFraction: 0.85), value: currentIndex)
        }
    }
}

#Preview {
    HorizontalStackedCards()
}
