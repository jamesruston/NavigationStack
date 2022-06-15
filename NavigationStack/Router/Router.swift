//
//  Router.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import Foundation

class Router {
    
    let matchers: [any RouteMatcher]
    
    init() {
        matchers = [
            GalleryRouteMatcher()
        ]
    }
    
    func route(for url: URL) -> (any Hashable)? {
        for matcher in matchers {
            guard let matchedRoute = matcher.match(for: url) else {
                continue
            }
            return matchedRoute
        }
        return nil
    }
}
