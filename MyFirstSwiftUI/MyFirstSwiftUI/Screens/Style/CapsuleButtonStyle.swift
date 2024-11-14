//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 14/11/24.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
	var bgColor: Color = .orange
	var textColor: Color = .white
	var hasBorder: Bool = false
	var gradientColors: [Color] = [.orange, .red]
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundColor(textColor)
			.padding()
			.frame(maxWidth: .infinity)
			.background(
				Capsule()
					.fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
					.shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
			)
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
			.animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
			.overlay {
				hasBorder ?
				Capsule()
					.strokeBorder(Color.gray, lineWidth: 1) :
				nil
			}
			.contentShape(Capsule())
	}
}
