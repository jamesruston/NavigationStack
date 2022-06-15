//
//  ContentView.swift
//  NavigationStack
//
//  Created by James Ruston on 14/06/2022.
//

import SwiftUI

class AppModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func deepLink(to url: URL) {
        let path = url.pathComponents
        guard path[1] == "gallery" else {
            return
        }
        let galleryRoute = GalleryRoute(id: path[2])
        navigationPath.append(galleryRoute)
    }
}

struct GalleryRoute: Hashable {
    let id: String
}

struct ContentView: View {
    @ObservedObject var tabModel: TabModel
    @EnvironmentObject var rootModel: RootModel
    
    @State var galleryId: String = ""
    var galleryRoute: String {
        "http://www.example.com/gallery/" + galleryId
    }
    
    var body: some View {
        VStack {
            Text("Navigation depth: \(tabModel.navigationPath.count)")
            NavigationStack(path: $tabModel.navigationPath) {
                List {
                    Section("Gallery Routing") {
                        TextField("Gallery ID", text: $galleryId)
                        Button {
                            tabModel.navigationPath.append(GalleryRoute(id: galleryId))
                        } label: {
                            Text("Route directly to: \(galleryId)")
                        }
                        Button {
                            rootModel.deepLink(to: URL(string: galleryRoute)!)
                        } label: {
                            Text("Route via deep link to:\n\(galleryRoute)")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationDestination(for: GalleryRoute.self) { galleryRoute in
                    GalleryView(id: galleryRoute.id)
                }
            }
        }
    }
}

enum Tab: String, CaseIterable, Identifiable {
    case home
    case browse
    case reminders
    case account
    case basket
    
    var id: String { rawValue }
    
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .browse:
            return "magnifyingglass"
        case .reminders:
            return "bell"
        case .account:
            return "person"
        case .basket:
            return "cart"
        }
    }
}

class TabModel: ObservableObject, Identifiable {
    let tab: Tab
    @Published var navigationPath = NavigationPath()
    
    var id: String { tab.rawValue }
    
    init(tab: Tab) {
        self.tab = tab
    }
}

class RootModel: ObservableObject {
    @Published var selectedTab: Tab = .home
    
    let tabs: [TabModel]
    
    init() {
        tabs = Tab.allCases.map { TabModel(tab: $0) }
    }
    
    var selectedTabModel: TabModel {
        tabs.first { $0.tab == selectedTab }!
    }
    
    func deepLink(to url: URL) {
        let path = url.pathComponents
        guard path[1] == "gallery" else {
            return
        }
        let galleryRoute = GalleryRoute(id: path[2])
        selectedTabModel.navigationPath.append(galleryRoute)
    }
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

struct GalleryView: View {
    let id: String
    var body: some View {
        Text("I'm a gallery for id: \(id)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
