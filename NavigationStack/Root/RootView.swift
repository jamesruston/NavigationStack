//
//  ContentView.swift
//  NavigationStack
//
//  Created by James Ruston on 14/06/2022.
//

import SwiftUI

struct GalleryRoute: Hashable {
    let id: String
}

struct RootView: View {
    @StateObject var rootModel = RootModel()
    
    var body: some View {
        TabView(selection: $rootModel.selectedTab) {
            ForEach(rootModel.tabs) { tabModel in
                ContentView(tabModel: tabModel)
                    .tag(tabModel.tab)
                    .tabItem {
                        Label(tabModel.tab.rawValue.capitalized, systemImage: tabModel.tab.imageName)
                    }
                    
            }
        }
        .environmentObject(rootModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
