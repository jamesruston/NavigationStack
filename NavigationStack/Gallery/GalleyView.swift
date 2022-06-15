//
//  GalleyView.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var rootModel: RootModel
    let id: String
    @State var nextGalleryId: String = ""
    var galleryRoute: String {
        "http://www.example.com/gallery/" + nextGalleryId
    }
    var body: some View {
        List {
            Section("Current Gallery") {
                Text("I'm a gallery for id: \(id)")
            }
            Section("Onward journey") {
                TextField("Gallery ID", text: $nextGalleryId)
                Button {
                    rootModel.deepLink(to: URL(string: galleryRoute)!)
                } label: {
                    Text("Route via deep link to:\n\(galleryRoute)")
                }
            }
        }.listStyle(.insetGrouped)
    }
}
