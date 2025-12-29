//
//  UnitTestStubs.swift
//  MovieViperTests
//
//  Created by Semih Özsoy on 29.12.2025.
//

import Foundation
import XCTest
@testable import MovieViper

final class UnitTestStubs {
    
    static var result: StubResult?
    
    enum StubResult {
        case success(Data)
        case failure(Error)
        
        var data: Data? {
            switch self {
            case .success(let data):
                return data
            case .failure:
                return nil
            }
        }
        
        var error: Error? {
            switch self {
            case .success:
                return nil
            case .failure(let error):
                return error
            }
        }
    }
    
    enum StubError: Error {
        case fileNotFound
        case invalidData
        case decodingError
        
        var localizedDescription: String {
            switch self {
            case .fileNotFound:
                return "Test dosyası bulunamadı"
            case .invalidData:
                return "Geçersiz veri"
            case .decodingError:
                return "Veri decode edilemedi"
            }
        }
    }
}

extension UnitTestStubs.StubResult {
    static func getData(withJsonName name: String) -> Self {
        .getData(
            from: Bundle(for: MoviesInteractorTest.self).path(forResource: name, ofType: "json")
        )
    }
    
    static func getData(from path: String?) -> Self {
        guard let path = path else {
            return .failure(UnitTestStubs.StubError.fileNotFound)
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return .success(data)
        } catch {
            return .failure(UnitTestStubs.StubError.invalidData)
        }
    }
    
    func decode<T: Decodable>(_ type: T.Type) -> T? {
        guard let data = self.data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            return nil
        }
    }
}

