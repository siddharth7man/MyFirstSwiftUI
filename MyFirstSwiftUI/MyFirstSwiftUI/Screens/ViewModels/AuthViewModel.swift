//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 20/11/24.
//

import Foundation
import FirebaseAuth // Auth
import FirebaseFirestore // Storage

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // firebase ka user
    @Published var currentUser: User? // apna vala user
    @Published var isError: Bool = false
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init() {
        Task {
            await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async {
        if let user = auth.currentUser {
            userSession = user
            await fetchUser(by: user.uid)
        }
    }
    
    func login(email: String, password: String) async {
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUser(by: authResult.user.uid)
        }catch {
            isError = true
        }
    }
    
    func createUser(email: String, fullName: String, password: String) async {
        do {
            // auth mai user ki entry kar rahe ho
            let authResult = try await auth.createUser(withEmail: email, password: password)
            // database user ki extra details store kar rahe ho
            await storeUserInFirestore(uid: authResult.user.uid, email: email, fullName: fullName)
        }catch {
            isError = true
        }
    }
    
    func storeUserInFirestore(uid: String, email: String, fullName: String) async {
        let user = User(uid: uid, email: email, fullName: fullName)
        do {
            try firestore.collection("users").document(uid).setData(from: user)
        }catch {
            isError = true
        }
    }
    
    func fetchUser(by uid: String) async {
        do {
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: User.self)
        }catch {
            isError = true
        }
    }
    
    func signOut() {
        do {
            userSession = nil
            currentUser = nil
            try auth.signOut()
        }catch {
            isError = true
        }
    }
    
    func deleteAccount() async {
        do {
            userSession = nil
            currentUser = nil
            deleteUser(by: auth.currentUser?.uid ?? "") // firestore database mai sai
            try await auth.currentUser?.delete() // auth mai sai remove hoga
        }catch {
            isError = true
        }
    }
    
    private func deleteUser(by uid: String) {
        firestore.collection("users").document(uid).delete()
    }
    
    func resetPassword(by email: String) async {
        do {
            try await auth.sendPasswordReset(withEmail: email)
        }catch {
            isError = true
        }
    }
}

@MainActor
final class HomeListViewModel: ObservableObject {
	
	@Published var homeData = HomeList(topType: [], benner: [], botomType: [])
	
	init() {
		setDeliveredData()
	}
	
	func setDeliveredData() {
		let data = HomeList(topType: [CategoriesList(type: "Type 1"), CategoriesList(type: "Type 2"), CategoriesList(type: "Type 3")], benner: [BannerList(typeimage: UIImage.earthWind), BannerList(typeimage: UIImage.fashionStreet), BannerList(typeimage: UIImage.freshThreads)], botomType: [CategoriesList(type: "B Type 1"), CategoriesList(type: "B Type 2"), CategoriesList(type: "B Type 3")])
		self.homeData = data
	}
	
}

// Define your data structures
struct HomeList {
	internal init(topType: [CategoriesList], benner: [BannerList], botomType: [CategoriesList]) {
		self.topType = topType
		self.benner = benner
		self.botomType = botomType
	}
	
	let topType: [CategoriesList]
	let benner: [BannerList]
	let botomType: [CategoriesList]
}

struct CategoriesList {
	internal init(type: String) {
		self.type = type
	}
	
	let type: String
}

struct BannerList {
	internal init(typeimage: UIImage) {
		self.typeimage = typeimage
	}
	
	let id = UUID()
	let typeimage: UIImage
}
