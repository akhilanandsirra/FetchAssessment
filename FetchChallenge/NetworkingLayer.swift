//
//  NetworkingLayer.swift
//  FetchChallenge
//
//  Created by Akhil Anand Sirra on 13/06/23.
//

import Foundation

protocol GenericAPI {
    var session: URLSession { get }
    func request<T: Decodable>(_ absoluteURL: String) async throws -> T
}

final class NetworkingLayer: GenericAPI {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    func request<T: Decodable>(_ absoluteURL: String) async throws -> T {
        guard let url = URL(string: absoluteURL) else { throw NetworkingError.invalidURL }
        
        let request = URLRequest(url: url)
        let response: (Data, URLResponse)
        
        do {
            response = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkingError.requestFailed(description: error.localizedDescription)
        }
        
        let httpResponse = response.1 as! HTTPURLResponse
        guard (200...300) ~= httpResponse.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try jsonDecoder.decode(T.self, from: response.0)
            return data
        } catch {
            throw NetworkingError.failedToDecode(description: error.localizedDescription)
        }
    }
}

extension NetworkingLayer {
    enum NetworkingError: Error {
        case requestFailed(description: String)
        case invalidURL
        case invalidData
        case invalidStatusCode(statusCode: Int)
        case failedToDecode(description: String)
        case jsonParsingFailure
        case failedSerialization
        case noInternet
        
        var customDescription: String {
            switch self {
            case let .requestFailed(description): return "Request Failed: \(description)"
            case .invalidURL: return "Invalid URL"
            case .invalidData: return "Invalid Data"
            case let .invalidStatusCode(statusCode): return "Status Code: \(statusCode)"
            case let .failedToDecode(description): return "JSON Decode Failure: \(description)"
            case .jsonParsingFailure: return "JSON Parsing Failure"
            case .failedSerialization: return "Serialization failed."
            case .noInternet: return "No internet connection"
            }
        }
    }
}
