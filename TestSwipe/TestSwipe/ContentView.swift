//
//  ContentView.swift
//  TestSwipe
//
//  Created by Abhisek Prusty on 19/04/26.
//

import SwiftUI

struct SwipeCardView: View {
    
    let items = ["ImageOne", "ImageTwo", "ImageThree", "ImageFour", "ImageFive", "ImageSix", "ImageSeven", "ImageEight", "ImageNine", "ImageTen" ]
    
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            ForEach(items.indices, id: \.self) { index in
                
                if index == currentIndex {
                    Image(items[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 380, height: 500)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .offset(x: dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    dragOffset = value.translation.width
                                }
                                .onEnded { value in
                                    handleSwipe(value: value.translation.width)
                                }
                        )
                        .animation(.spring(), value: dragOffset)
                }
            }
        }
    }
    
    // MARK: - Swipe Logic
    func handleSwipe(value: CGFloat) {
        
        let threshold: CGFloat = 100
        
        if value > threshold {
            // Swipe Right
            currentIndex = max(currentIndex - 1, 0)
        } else if value < -threshold {
            // Swipe Left
            currentIndex = min(currentIndex + 1, items.count - 1)
        }
        
        dragOffset = 0
    }
}

#Preview {
    SwipeCardView()
}
