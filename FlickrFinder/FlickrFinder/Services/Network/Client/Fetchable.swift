//
//  Fetchable.swift
//  FlickrFinder
//
//  Created by Omar Noppe on 25/02/2023.
//

import Foundation

protocol Fetchable {
    func fetch<T: Decodable>(_ endpoint: Endpoint,
                             model: T.Type) async -> Result<T, NetworkError>
}

// MARK: - Public

extension Fetchable {
    func fetch<T: Decodable>(_ endpoint: Endpoint,
                             model: T.Type) async -> Result<T, NetworkError> {

        guard let url = getUrl(from: endpoint) else {
            return .failure(.invalidUrl)
        }

        let request = getRequest(from: endpoint, url: url)

        do {
            let result = try await URLSession.shared.data(for: request)
            return transform(from: result, type: model)
        } catch {
            return .failure(.unknown)
        }
    }
}

// MARK: - Private Helper Methods

private extension Fetchable {

    func getUrl(from endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        urlComponents.scheme = endpoint.scheme
        urlComponents.queryItems = endpoint.queryItems
        return urlComponents.url
    }

    func getRequest(from endpoint: Endpoint, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        return request
    }

    func transform<T: Decodable>(from result: (data: Data, response: URLResponse), type: T.Type) -> Result<T, NetworkError> {

        guard let response = result.response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }

        switch response.statusCode {
        case 200...299:

            guard let model = try? JSONDecoder().decode(type, from: result.data) else {
                return .failure(.decode)
            }

            return .success(model)
        case 401:
            return .failure(.unauthorized)
        default:
            return .failure(.statusCode)
        }
    }
}

