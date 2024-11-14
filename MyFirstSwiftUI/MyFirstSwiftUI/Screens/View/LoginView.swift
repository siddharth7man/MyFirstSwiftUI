//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 14/11/24.
//

import SwiftUI

struct LoginView: View {
	
	@State private var email: String = ""
	@State private var password: String = ""
	
	var body: some View {
		ScrollView {
			VStack(spacing: 16) {
				// title
				titleView
				
				Spacer().frame(height: 12)
				
				// textfields
				InputView(
					placeholder: "Enter Email",
					text: $email
				)
				
				InputView(
					placeholder: "Password",
					isSecureField: true,
					text: $password
				)
				// forgot button
				forgotButton
				
				// login button
				loginButton
				
				Spacer()
				
				// bottom view
				bottomView
			}
		}
		.ignoresSafeArea()
		.padding(.horizontal)
		.padding(.vertical, 10)
		.background(
			LinearGradient(
				gradient: Gradient(colors: [.white, .gray]),
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
		)
	}
	
	private var logo: some View {
		Image("login_image")
			.resizable()
			.scaledToFit()
	}
	
	private var titleView: some View {
		Text("Let's Connect Together!")
			.font(.title2)
			.fontWeight(.semibold)
	}
	
	private var forgotButton: some View {
		HStack {
			Spacer()
			Button {
			} label: {
				Text("Forgot your login?")
					.foregroundStyle(.gray)
					.font(.subheadline)
					.fontWeight(.medium)
			}
		}
	}
	
	private var loginButton: some View {
		Button {
			Task {
			}
		} label: {
			Text("Sign in")
		}
		.buttonStyle(CapsuleButtonStyle())
	}
	
	private var line: some View {
		VStack { Divider().frame(height: 1) }
	}
	
	private var bottomView: some View {
		VStack(spacing: 16) {
			lineorView
			appleButton
			googleButton
			footerView
		}
	}
	
	private var lineorView: some View {
		HStack(spacing: 16) {
			line
			Text("or")
				.fontWeight(.semibold)
			line
		}
		.foregroundStyle(.gray)
	}
	
	private var appleButton: some View {
		Button {
			
		} label: {
			Label("Sign up with Apple", systemImage: "apple.logo")
		}
		.buttonStyle(
			CapsuleButtonStyle(
				bgColor: .black
			)
		)
	}
	
	private var googleButton: some View {
		Button {
			
		} label: {
			Label("Sign up with Google", systemImage: "google.logo")
		}
		.buttonStyle(
			CapsuleButtonStyle(
				bgColor: .black
			)
		)
	}
	
	private var footerView: some View {
		Button {
		} label: {
			HStack {
				Text("No account yet?")
					.foregroundStyle(.black)
				Text("Sign up now!")
					.foregroundStyle(.orange)
			}
			.fontWeight(.medium)
		}
	}
}

#Preview {
	LoginView()
}
