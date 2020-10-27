//
//  ImageLoader.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/23/20.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL
    private var cancellable: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    
    private let placeholder: Placeholder

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()

        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}
