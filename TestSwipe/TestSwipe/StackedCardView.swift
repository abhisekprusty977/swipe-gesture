//
//  StackedCardView.swift
//  TestSwipe
//
//  Created by Abhisek Prusty on 19/04/26.
//

import SwiftUI

struct SimpleSwipeView: View {
    
    let items = ["ImageOne", "ImageTwo", "ImageThree", "ImageFour"]
    
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geo in
            
            let width = geo.size.width
            
            HStack(spacing: 0) {
                
                ForEach(items, id: \.self) { item in
                    Image(item)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: 450)
                        .clipped()
                }
            }
            
            // 👉 Move full screen per swipe
            .offset(x: -CGFloat(currentIndex) * width + dragOffset)
            
            // 👉 Gesture
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        
                        let threshold = width / 3
                        
                        if value.translation.width < -threshold {
                            currentIndex = min(currentIndex + 1, items.count - 1)
                        }
                        else if value.translation.width > threshold {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    }
            )
            
            // 👉 Smooth animation
            .animation(.easeInOut, value: currentIndex)
        }
    }
}

#Preview {
    SimpleSwipeView()
}
