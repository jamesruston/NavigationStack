//
//  ContentView.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var tabModel: TabModel
    @EnvironmentObject var rootModel: RootModel
    
    @State var galleryId: String = ""
    var galleryRoute: String {
        "http://www.example.com/gallery/" + galleryId
    }
    
    var body: some View {
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
