//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 14/11/24.
//

import SwiftUI
import FirebaseCore
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	FirebaseApp.configure()

	return true
  }
}

@main
struct MyFirstSwiftUIApp: App {
	
	// register app delegate for Firebase setup
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	@StateObject private var authViewModel = AuthViewModel()
	@ObservedObject private var router = Router()
	
	var body: some Scene {
		WindowGroup {
			NavigationStack(path: $router.navPath) {
				ContentView(viewModel: HomeListViewModel())
					.navigationDestination(for: Router.AuthFlow.self) { destination in
						switch destination {
						case .login: LoginView()
						case .signUP: SignUPView()
						case .profile: HomeView()
						case .forgotPassword: SignUPView()
						case .emailSent: SignUPView()
						case .home:SignUPView()
						}
					}
			}
			.environmentObject(authViewModel)
			.environmentObject(router)
		}
	}
}
