//
//  HomeView.swift
//  MyFirstSwiftUI
//
//  Created by Siddharth on 25/12/24.
//

import SwiftUI

struct ContentView: View {
	
	@ObservedObject var viewModel: HomeListViewModel
	
	var body: some View {
		List {
			Section(header: Text("Section 1")) {
				
//				ForEach(viewModel.homeData.topType, id: \.id) { category in
//					Text(category.type)
//				}
			}

			Section(header: Text("Section 2")) {
				ForEach(viewModel.homeData.benner, id: \.id) { banner in
					Image(uiImage: banner.typeimage)
						.resizable()
						.scaledToFit()
				}
			}

			Section(header: Text("Section 3")) {
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 20) {
//						ForEach(viewModel.homeData.botomType, id: \.id) { category in
//							Text(category.type)
//								.padding(10)
//								.background(Color.gray.opacity(0.2))
//								.cornerRadius(5)
//						}
					}
				}
			}
		}
		.listStyle(InsetGroupedListStyle())
	}
}

// ... (Rest of the code for HomeListViewModel, HomeList, CategoriesList, BannerList, and UIImage extensions) ...

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(viewModel: HomeListViewModel())
	}
}
