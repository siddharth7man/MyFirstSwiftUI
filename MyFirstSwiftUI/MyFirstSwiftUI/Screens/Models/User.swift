//
//  MyFirstSwiftUIApp.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 20/11/24.
//


import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let fullName: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
