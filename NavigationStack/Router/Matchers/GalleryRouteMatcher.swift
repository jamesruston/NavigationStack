//
//  GalleryRouteMatcher.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import Foundation

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
