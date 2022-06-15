//
//  Tab.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import Foundation

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
