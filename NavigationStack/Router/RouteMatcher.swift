//
//  RouteMatcher.swift
//  NavigationStack
//
//  Created by James Ruston on 15/06/2022.
//

import Foundation

protocol RouteMatcher {
    associatedtype Match: Hashable
    
    func match(for url: URL) -> Match?
}
