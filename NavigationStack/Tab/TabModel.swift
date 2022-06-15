//
//  TabModel.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import SwiftUI

class TabModel: ObservableObject, Identifiable {
    let tab: Tab
    @Published var navigationPath = NavigationPath()
    
    var id: String { tab.rawValue }
    
    init(tab: Tab) {
        self.tab = tab
    }
}
