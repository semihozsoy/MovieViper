//
//  MoviesViewInterfaceSpy.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//

import XCTest
@testable import MovieViper

final class MoviesViewInterfaceSpy: MoviesViewInterface {
    
    var prepareIndicatorCalled = false
    var stopAnimatingCalled = false
    var startAnimatingCalled = false
    var reloadDataCalled = false
    var setupInitialViewCalled = false
    var setScreenTitleCalled = false
    
    var capturedTitle: String?
    
    func prepareIndicator() {
        prepareIndicatorCalled = true
    }
    
    func stopAnimating() {
        stopAnimatingCalled = true
    }
    
    func startAnimating() {
        startAnimatingCalled = true
    }
    
    func reloadData() {
        reloadDataCalled = true
    }
    
    func setupInitialView() {
        setupInitialViewCalled = true
    }
    
    func setScreenTitle(with title: String) {
        setScreenTitleCalled = true
        capturedTitle = title
    }
}
