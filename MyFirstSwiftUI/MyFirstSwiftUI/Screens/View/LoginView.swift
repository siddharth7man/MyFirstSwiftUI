//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 20/11/24.
//

import SwiftUI

struct LoginView: View {
	
	@State private var email: String = ""
	@State private var password: String = ""
	@EnvironmentObject var router: Router

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
			router.navigate(to: .signUP)
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
			router.navigate(to: .signUP)
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
struct HomeView: View {
	@StateObject private var viewModel = HomeViewModel()
	
	var body: some View {
		NavigationView {
			List {
				Section(header: Text("Trending")) {
					ForEach(viewModel.trendingMovies) { movie in
						NavigationLink(destination: MovieDetailView(movie: movie)) {
							MovieRow(movie: movie)
						}
					}
				}
				
				Section(header: Text("Popular")) {
					ForEach(viewModel.popularMovies) { movie in
						NavigationLink(destination: MovieDetailView(movie: movie)) {
							MovieRow(movie: movie)
						}
					}
				}
			}
			.navigationTitle("Movies")
			.onAppear {
				viewModel.loadTrendingMovies()
				viewModel.loadPopularMovies()
			}
		}
	}
}

struct MovieDetailView: View {
	let movie: Movie
	@State private var isFavorite = false
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 10) {
				Text(movie.title).font(.title)
				Text(movie.overview).font(.body)
				Button(action: toggleFavorite) {
					Text(isFavorite ? "Unfavorite" : "Favorite")
				}
			}
			.padding()
		}
		.onAppear {
			loadFavoriteStatus()
		}
	}
	
	private func toggleFavorite() {
		isFavorite.toggle()
		// Save favorite status
	}
	
	private func loadFavoriteStatus() {
		// Load favorite status
	}
}

struct MovieRow: View {
	let movie: Movie

	var body: some View {
		HStack {
			// Load movie poster
			if let posterPath = movie.posterPath {
				AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)) { image in
					image.resizable()
						.frame(width: 50, height: 75)
						.cornerRadius(8)
				} placeholder: {
					Color.gray
						.frame(width: 50, height: 75)
						.cornerRadius(8)
				}
			}
			
			VStack(alignment: .leading) {
				Text(movie.title)
					.font(.headline)
				Text(movie.releaseDate)
					.font(.subheadline)
					.foregroundColor(.gray)
			}
		}
	}
}
struct OtherView1: View {
  var body: some View {
	Text("Tab 1 Content")
  }
}

struct OtherView2: View {
  var body: some View {
	Text("Tab 2 Content")
  }
}

struct OtherView3: View {
  var body: some View {
	Text("Tab 3 Content")
  }
}
