//
//  MemeList+ViewModel.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/26/20.
//

import Foundation
import Combine

extension MemeListView {
    class ViewModel: ObservableObject {
        @Published var memes: [Meme.Info] = []

        private let memeFetcher = Meme.Fetcher()
        private var disposables = Set<AnyCancellable>()

        func fetchMemes() {
            memeFetcher.fetchMemes()
                .receive(on: DispatchQueue.main)
                .sink { (completion) in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { (memes) in
                    self.memes = memes.data.memes
                }
                .store(in: &disposables)
        }
    }
}
