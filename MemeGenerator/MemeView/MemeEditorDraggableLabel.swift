//
//  MemeEditorDraggableLabel.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/26/20.
//

import SwiftUI

struct MemeEditorDraggableLabel: View {
    // Drag Gesture
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero

    // Roation Gesture
    @State private var rotation: Double = 0.0

    // Scale Gesture
    @State private var scale: CGFloat = 1.0

    // Tap Gesture
    @State private var labelColor: Color = .black

    private enum WidthState: Int {
        case full, half, third, fourth
    }

    @State private var widthState: WidthState = .full
    @State private var currentWidth: CGFloat = UIScreen.main.bounds.width

    var text: String

    var body: some View {
        VStack {
            Text(text)
                .shadow(color: labelColor == .black ? .white : .black,
                        radius: 5,
                        x: 0,
                        y: 0)
                .frame(width: self.currentWidth)
                .lineLimit(nil)
                .font(.system(size: 36,
                              weight: .bold,
                              design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(labelColor)
        }
        .scaleEffect(scale)
        .rotationEffect(Angle.degrees(rotation))
        .offset(x: self.currentPosition.width,
                y: self.currentPosition.height)
        .gesture(
            RotationGesture()
                .onChanged { angle in
                    self.rotation = angle.degrees
                }
                .simultaneously(with:
                                    MagnificationGesture()
                                        .onChanged { scale in
                                            self.scale = scale.magnitude
                                        })
                .simultaneously(with: DragGesture()
                                    .onChanged { value in
                                        self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
                                                                      height: value.translation.height + self.newPosition.height)
                                    }
                                    .onEnded { value in
                                        self.newPosition = self.currentPosition
                                    })
        )
        .onTapGesture(count: 2) {
            self.widthState = WidthState(rawValue: self.widthState.rawValue + 1) ?? .full
            self.currentWidth = UIScreen.main.bounds.width / CGFloat(self.widthState.rawValue)
        }
        .onTapGesture(count: 1) {
            self.labelColor = self.labelColor == .black ? .white : .black
        }
    }
}

struct MemeEditorDraggableLabel_Previews: PreviewProvider {
    static var previews: some View {
        MemeEditorDraggableLabel(text: "Work")
    }
}
