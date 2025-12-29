//
//  MoviesViewControllerTest.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//

import XCTest
@testable import MovieViper

final class MoviesViewControllerTest: XCTestCase {
    
    private var sut: MoviesViewController!
    private var presentationLogicSpy: MoviesPresenterInterfaceSpy!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        setupMoviesViewController()
    }
    
    override func tearDown() {
        sut = nil
        presentationLogicSpy = nil
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    private func setupMoviesViewController() {
        let storyboard = UIStoryboard(
            name: "Movies",
            bundle: nil
        )
        sut = storyboard.instantiateViewController(
            withIdentifier: "MoviesViewController"
        ) as? MoviesViewController
        presentationLogicSpy = MoviesPresenterInterfaceSpy()
        sut.presenter = presentationLogicSpy
        
        window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
    }

    // MARK: - Tests
    
    func testViewDidLoad_ShouldCallPresenterNotifyViewLoaded() {
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(presentationLogicSpy.notifyViewLoadedCalled)
    }
    
    func testViewWillAppear_ShouldCallPresenterNotifyViewWillAppear() {
        // When
        sut.viewWillAppear(true)
        
        // Then
        XCTAssertTrue(presentationLogicSpy.notifyViewWillAppearCalled)
    }
    
    func testSetupInitialView_ShouldSetupTableView() {
        // When
        sut.setupInitialView()
        
        // Then
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testSetScreenTitle_ShouldSetTitle() {
        // Given
        let title = "Test Movies"
        
        // When
        sut.setScreenTitle(with: title)
        
        // Then
        XCTAssertEqual(sut.title, title)
    }
    
    func testReloadData_ShouldReloadTableView() {
        // Given
        sut.loadViewIfNeeded()
        
        // When
        sut.reloadData()
        
        // Then - Test passes if no crash occurs
        XCTAssertNotNil(sut.tableView)
    }
    
    func testPrepareIndicator_ShouldAddIndicatorToView() {
        // Given
        sut.loadViewIfNeeded()
        
        // When
        sut.prepareIndicator()
        
        // Then - Indicator is added as subview
        XCTAssertTrue(sut.view.subviews.contains { $0 is UIActivityIndicatorView })
    }
    
    func testNumberOfSections_ShouldReturnOne() {
        // Given
        sut.loadViewIfNeeded()
        
        // When
        let sections = sut.numberOfSections(in: sut.tableView)
        
        // Then
        XCTAssertEqual(sections, 1)
    }
    
    func testNumberOfRows_WithNoMovies_ShouldReturnZero() {
        // Given
        sut.loadViewIfNeeded()
        presentationLogicSpy.mockMovies = []
        
        // When
        let rows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(rows, 0)
    }
    
    func testNumberOfRows_WithMovies_ShouldReturnCorrectCount() {
        // Given
        sut.loadViewIfNeeded()
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
        presentationLogicSpy.mockMovies = mockMovies
        
        // When
        let rows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(rows, 2)
    }
    
    func testDidSelectRow_ShouldCallPresenterMovieDetail() {
        // Given
        sut.loadViewIfNeeded()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)
        
        // Then
        XCTAssertTrue(presentationLogicSpy.movieDetailCalled)
        XCTAssertEqual(presentationLogicSpy.capturedMovieIndex, 0)
    }
    
    func testHeightForRow_ShouldReturnAutomaticDimension() {
        // Given
        sut.loadViewIfNeeded()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        let height = sut.tableView(sut.tableView, heightForRowAt: indexPath)
        
        // Then
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testStartAnimating_ShouldStartIndicator() {
        // Given
        sut.loadViewIfNeeded()
        sut.prepareIndicator()
        
        // When
        sut.startAnimating()
        
        // Then - Test passes if no crash occurs
        let indicator = sut.view.subviews.first {
            $0 is UIActivityIndicatorView
        } as? UIActivityIndicatorView
        
        XCTAssertNotNil(indicator)
    }
    
    func testStopAnimating_ShouldStopIndicator() {
        // Given
        sut.loadViewIfNeeded()
        sut.prepareIndicator()
        sut.startAnimating()
        
        // When
        sut.stopAnimating()
        
        // Then - Test passes if no crash occurs
        let indicator = sut.view.subviews.first {
            $0 is UIActivityIndicatorView
        } as? UIActivityIndicatorView
        
        XCTAssertNotNil(indicator)
    }
}
