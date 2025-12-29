//
//  MoviesInteractorTest.swift
//  MovieViper
//
//  Created by Semih Özsoy on 29.12.2025.
//
import XCTest
@testable import MovieViper

final class MoviesInteractorTest: XCTestCase {
    
    private var sut: MoviesInteractor!
    private var workingLogicSpy: MoviesInteractorInterfaceSpy!
    private var presentationLogicSpy: MoviesPresenterInterfaceSpy!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        setupMoviesInteractor()
        UnitTestStubs.result = nil
    }
    
    override func tearDown() {
        sut = nil
        presentationLogicSpy = nil
        workingLogicSpy = nil
        UnitTestStubs.result = nil
        super.tearDown()
    }

    // MARK: - Test setup

    private func setupMoviesInteractor() {
        sut = MoviesInteractor()
        presentationLogicSpy = MoviesPresenterInterfaceSpy()
        workingLogicSpy = MoviesInteractorInterfaceSpy()
        sut.presenter = presentationLogicSpy
    }

    // MARK: - Tests
    
    func testFetchMovies_WhenSuccessful_ShouldCallPresenter() {
        // Given
        UnitTestStubs.result = .getData(withJsonName: "movies_response")
        
        // When
        workingLogicSpy.presenter = presentationLogicSpy
        workingLogicSpy.fetchMovies()
        
        // Then
        XCTAssertTrue(presentationLogicSpy.moviesFetchedCalled)
        XCTAssertNotNil(presentationLogicSpy.capturedResponse)
        XCTAssertEqual(presentationLogicSpy.capturedResponse?.count, 3)
    }
    
    func testFetchMovies_WhenEmptyResponse_ShouldReturnEmptyArray() {
        // Given
        UnitTestStubs.result = .getData(withJsonName: "empty_movies_response")
        
        // When
        workingLogicSpy.presenter = presentationLogicSpy
        workingLogicSpy.fetchMovies()
        
        // Then
        XCTAssertTrue(presentationLogicSpy.moviesFetchedCalled)
        XCTAssertEqual(presentationLogicSpy.capturedResponse?.count, 0)
    }
    
    func testFetchMovies_WhenFailed_ShouldCallPresenterWithError() {
        // Given
        workingLogicSpy.shouldReturnError = true
        
        // When
        workingLogicSpy.presenter = presentationLogicSpy
        workingLogicSpy.fetchMovies()
        
        // Then
        XCTAssertTrue(presentationLogicSpy.moviesFetchedFailedCalled)
        XCTAssertNotNil(presentationLogicSpy.capturedErrorMessage)
        XCTAssertEqual(presentationLogicSpy.capturedErrorMessage, "Test error message")
    }
    
    func testFetchMovies_WithMockData_ShouldReturnCorrectData() {
        // Given
        let mockMovies = [
            MoviesTestModel(
                movieId: 1,
                movieName: "Batman",
                movieImage: "https://movies.batman",
                movieYear: "2012",
                movieDetail: "Excellent movie"
            ),
            MoviesTestModel(
                movieId: 2,
                movieName: "Superman",
                movieImage: "https://movies.superman",
                movieYear: "2013",
                movieDetail: "Great movie"
            )
        ]
        workingLogicSpy.mockResponse = mockMovies
        
        // When
        workingLogicSpy.presenter = presentationLogicSpy
        workingLogicSpy.fetchMovies()
        
        // Then
        XCTAssertTrue(presentationLogicSpy.moviesFetchedCalled)
        XCTAssertEqual(presentationLogicSpy.capturedResponse?.count, 2)
        XCTAssertEqual(presentationLogicSpy.capturedResponse?.first?.movieName, "Batman")
        XCTAssertEqual(presentationLogicSpy.capturedResponse?.first?.movieId, 1)
    }
    
    func testInteractor_ShouldHaveWeakPresenterReference() {
        // Given
        var presenter: MoviesPresenterInterfaceSpy? = MoviesPresenterInterfaceSpy()
        sut.presenter = presenter
        
        // When
        presenter = nil
        
        // Then
        XCTAssertNil(sut.presenter, "Presenter should be weak reference")
    }
}

struct MoviesTestModel: MovieItems {
    var movieId: Int?
    var movieName: String?
    var movieImage: String?
    var movieYear: String?
    var movieDetail: String?
}
