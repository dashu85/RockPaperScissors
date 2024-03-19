//
//  GrayBackground.swift
//  RockPaperScissors
//
//  Created by Marcus Benoit on 19.03.24.
//

import SwiftUI

struct GrayBackground: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .opacity(0.6)
                }
                .font(.system(size: 70))
        }
    }

// for a simpler implementation we can create a View extension to just call .BVBModifier
extension View {
        func grayBackground() -> some View {
            modifier(GrayBackground())
        }
    }
