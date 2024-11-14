//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 14/11/24.
//

import SwiftUI

struct InputView: View {
	let placeholder: String
	var isSecureField: Bool = false
	var icon: String? = nil
	@Binding var text: String
	
	var body: some View {
		VStack(spacing: 8) {
			HStack {
				if let icon = icon {
					Image(systemName: icon)
						.foregroundColor(.gray)
				}
				
				if isSecureField {
					SecureField(placeholder, text: $text)
						.foregroundColor(.primary)
						.padding(.vertical, 10)
						.padding(.horizontal, 8)
				} else {
					TextField(placeholder, text: $text)
						.foregroundColor(.primary)
						.padding(.vertical, 10)
						.padding(.horizontal, 8)
				}
			}
			.background(
				RoundedRectangle(cornerRadius: 8)
					.stroke(Color.gray.opacity(0.6), lineWidth: 1)
					.background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
			)
			.overlay(
				RoundedRectangle(cornerRadius: 8)
					.stroke(Color.orange.opacity(text.isEmpty ? 0 : 1), lineWidth: 1)
			)
			.padding(.horizontal)
		}
		.padding(.top, 4)
	}
}

#Preview {
	InputView(
		placeholder: "Enter Email",
		icon: "envelope",
		text: .constant("")
	)
}
