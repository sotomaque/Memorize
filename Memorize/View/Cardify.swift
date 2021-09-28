//
//  Cardify.swift
//  Memorize
//
//  Created by Enrique Sotomayor on 9/27/21.
//

import Foundation
import SwiftUI

struct Cardify: AnimatableModifier {
        
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double // in degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
                content.opacity(rotation < 90 ? 1.0 : 0.0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    // MARK: CONSTANTS
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}
