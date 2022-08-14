//
//  EmonotateAPIClient.swift
//  Carvide
//
//  Created by 番庄智也 on 2022/08/13.
//

import Foundation

public struct EmonotateAPIClient {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    public func send(with: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: with)
    }
}
