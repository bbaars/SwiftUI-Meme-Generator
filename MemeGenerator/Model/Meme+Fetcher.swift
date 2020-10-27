//
//  Meme+Fetcher.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/26/20.
//

import Foundation
import Combine

extension Meme {
    class Fetcher: ObservableObject {
        enum FetchingError: Error, LocalizedError {
            case unknown
            case decodingError(reason: String)

            var errorDescription: String? {
                switch self {
                case .unknown:
                    return "Unknown error"
                case .decodingError(let reason):
                    return reason
                }
            }
        }

        // URL API (Note: It's better practive to not have this hard coded, but to create an object that constructs various endpoints that's reusable)
        // For this tutorial, we are only hitting one endpoint and it's specific enough to the one API call we have.
        private let url = URL(string: "https://api.imgflip.com/get_memes")!


        /// Fetch all the popular memes
        /// - Returns: AnyPublisher<Meme, APIError> - Meme data or the API error if one exists
        func fetchMemes() -> AnyPublisher<Meme, FetchingError> {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { $0.data }
                .decode(type: Meme.self, decoder: decoder)
                .mapError { error -> FetchingError in
                    if error is DecodingError {
                        return FetchingError.decodingError(reason: error.localizedDescription)
                    }

                    return FetchingError.unknown
                }
                .eraseToAnyPublisher()
        }
    }
}
