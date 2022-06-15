//
//  RootModel.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import SwiftUI

class RootModel: ObservableObject {
    @Published var selectedTab: Tab = .home
    private let router = Router()
    
    let tabs: [TabModel]
    
    init() {
        tabs = Tab.allCases.map { TabModel(tab: $0) }
    }
    
    var selectedTabModel: TabModel {
        tabs.first { $0.tab == selectedTab }!
    }
    
    func deepLink(to url: URL) {
        guard let match = router.route(for: url) else { return }
        
        selectedTabModel.navigationPath.append(match)
    }
}
