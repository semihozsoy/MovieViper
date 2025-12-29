//
//  MoviesPresenterTest.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//

import XCTest
@testable import MovieViper

final class MoviesPresenterTest: XCTestCase {
    
    private var sut: MoviesPresenter!
    private var workingLogicSpy: MoviesInteractorInterfaceSpy!
    private var presentationLogicSpy: MoviesPresenterInterfaceSpy!
    private var routingLogicSpy: MoviesRouterInterfaceSpy!
    private var viewControllerLogicSpy: MoviesViewInterfaceSpy!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        setupMoviesPresenter()
    }
    
    override func tearDown() {
        sut = nil
        workingLogicSpy = nil
        routingLogicSpy = nil
        viewControllerLogicSpy = nil
        super.tearDown()
    }

    // MARK: - Test setup

    private func setupMoviesPresenter() {
        sut = MoviesPresenter()
        presentationLogicSpy = MoviesPresenterInterfaceSpy()
        routingLogicSpy = MoviesRouterInterfaceSpy()
        workingLogicSpy = MoviesInteractorInterfaceSpy()
        viewControllerLogicSpy = MoviesViewInterfaceSpy()
        sut.view = viewControllerLogicSpy
        sut.router = routingLogicSpy
        sut.interactor = workingLogicSpy
    }

    // MARK: - Tests
    
    func testNotifyViewLoaded_ShouldCallViewMethods() {
        // When
        sut.notifyViewLoaded()
        
        // Then
        XCTAssertTrue(viewControllerLogicSpy.setupInitialViewCalled)
        XCTAssertTrue(viewControllerLogicSpy.prepareIndicatorCalled)
        XCTAssertTrue(workingLogicSpy.fetchMoviesCalled)
    }
    
    func testNotifyViewWillAppear_ShouldSetScreenTitle() {
        // When
        sut.notifyViewWillAppear()
        
        // Then
        XCTAssertTrue(viewControllerLogicSpy.setScreenTitleCalled)
        XCTAssertEqual(viewControllerLogicSpy.capturedTitle, "Movies")
    }
    
    func testMoviesFetched_WithValidResponse_ShouldUpdateViewModelsAndReloadData() {
        // Given
        let mockMovies: [MovieItems] = [
            MoviesTestModel(
                movieId: 1,
                movieName: "The Dark Knight",
                movieImage: "/poster1.jpg",
                movieYear: "2008-07-18",
                movieDetail: "Batman raises the stakes"
            )
        ]
        
        let expectation = self.expectation(description: "Async completion")
        
        // When
        sut.moviesFetched(mockMovies)
        
        // Wait for async dispatch
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            // Then
            XCTAssertEqual(self.sut.movieViewModels?.count, 1)
            XCTAssertTrue(self.viewControllerLogicSpy.startAnimatingCalled)
            XCTAssertTrue(self.viewControllerLogicSpy.reloadDataCalled)
            XCTAssertTrue(self.viewControllerLogicSpy.stopAnimatingCalled)
        }
    }
    
    func testMoviesFetched_WithEmptyResponse_ShouldUpdateViewModelsAsEmpty() {
        // Given
        let emptyMovies: [MovieItems] = []
        let expectation = self.expectation(description: "Async completion")
        
        // When
        sut.moviesFetched(emptyMovies)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            // Then
            XCTAssertEqual(self.sut.movieViewModels?.count, 0)
        }
    }
    
    func testMoviesFetchedFailed_ShouldPresentPopUp() {
        // Given
        let errorMessage = "Network error occurred"
        
        // When
        sut.moviesFetchedFailed(with: errorMessage)
        
        // Then
        XCTAssertTrue(routingLogicSpy.presentPopUpCalled)
        XCTAssertEqual(routingLogicSpy.capturedPopUpMessage, errorMessage)
    }
    
    func testGetMovieViewModels_ShouldReturnStoredMovies() {
        // Given
        let mockMovies: [MovieItems] = [
            MoviesTestModel(
                movieId: 1,
                movieName: "The Dark Knight",
                movieImage: "/poster1.jpg",
                movieYear: "2008-07-18",
                movieDetail: "Batman raises the stakes"
            )
        ]
        sut.movieViewModels = mockMovies
        
        // When
        let viewModels = sut.getMovieViewModels()
        
        // Then
        XCTAssertEqual(viewModels?.count, 1)
        XCTAssertEqual(viewModels?.first?.movieName, "The Dark Knight")
    }
    
    func testGetMovieViewModels_WhenNoData_ShouldReturnNil() {
        // Given
        sut.movieViewModels = nil
        
        // When
        let viewModels = sut.getMovieViewModels()
        
        // Then
        XCTAssertNil(viewModels)
    }
    
    func testMovieDetail_WithValidIndex_ShouldRouteToDetail() {
        // Given
        let mockMovies: [MovieItems] = [
            MoviesTestModel(
                movieId: 1,
                movieName: "Movie 1",
                movieImage: nil,
                movieYear: nil,
                movieDetail: nil
            ),
            MoviesTestModel(
                movieId: 2,
                movieName: "Movie 2",
                movieImage: nil,
                movieYear: nil,
                movieDetail: nil
            )
        ]
        sut.movieViewModels = mockMovies
        
        // When
        sut.movieDetail(0)
        
        // Then
        XCTAssertTrue(routingLogicSpy.routeToDetailCalled)
        XCTAssertEqual(routingLogicSpy.capturedMovieId, 1)
    }
    
    func testMovieDetail_WithLastIndex_ShouldRouteToCorrectDetail() {
        // Given
        let mockMovies: [MovieItems] = [
            MoviesTestModel(
                movieId: 1,
                movieName: "Movie 1",
                movieImage: nil,
                movieYear: nil,
                movieDetail: nil
            ),
            MoviesTestModel(
                movieId: 2,
                movieName: "Movie 2",
                movieImage: nil,
                movieYear: nil,
                movieDetail: nil
            )
        ]
        sut.movieViewModels = mockMovies
        
        // When
        sut.movieDetail(1)
        
        // Then
        XCTAssertTrue(routingLogicSpy.routeToDetailCalled)
        XCTAssertEqual(routingLogicSpy.capturedMovieId, 2)
    }
    
    func testPresenter_ShouldHaveWeakViewReference() {
        // Given
        var view: MoviesViewInterfaceSpy? = MoviesViewInterfaceSpy()
        sut.view = view
        
        // When
        view = nil
        
        // Then
        XCTAssertNil(sut.view, "View should be weak reference")
    }
}
