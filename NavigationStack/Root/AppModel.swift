//
//  AppModel.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import SwiftUI

//class AppModel: ObservableObject {
//    @Published var navigationPath = NavigationPath()
//    private let router = Router()
//    
//    func deepLink(to url: URL) {
//        let path = url.pathComponents
//        guard path[1] == "gallery" else {
//            return
//        }
//        let galleryRoute = GalleryRoute(id: path[2])
//        navigationPath.append(galleryRoute)
//    }
//}

class Router {
    
    let matchers: [any RouteMatcher]
    
    init() {
        matchers = [
            GalleryRouteMatcher()
        ]
    }
    
    func route(for url: URL) -> (any Hashable)? {
        for matcher in matchers {
            guard let matchedRoute = match(for: url, matcher: matcher) else {
                continue
            }
            return matchedRoute
        }
        return nil
    }
    
    func match<Matcher: RouteMatcher>(for url: URL, matcher: Matcher) -> Matcher.Match? {
        matcher.match(for: url)
    }
}

protocol RouteMatcher {
    associatedtype Match: Hashable
    
    func match(for url: URL) -> Match?
}

class GalleryRouteMatcher: RouteMatcher {
    
    let regex = /\/gallery\/(\w+)/
    
    func match(for url: URL) -> GalleryRoute? {
        guard let match = try? regex.wholeMatch(in: url.path()) else {
            return nil
        }
        let (_, id) = match.output
        
        return GalleryRoute(id: String(id))
    }
}
