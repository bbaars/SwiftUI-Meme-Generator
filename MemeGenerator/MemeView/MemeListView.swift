//
//  ContentView.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/26/20.
//

import SwiftUI

struct MemeListView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.memes, id: \.self) { meme in
                NavigationLink(destination: MemeEditorView(from: meme)) {
                    MemeView(meme: meme)
                }
            }
        }
        .onAppear {
            viewModel.fetchMemes()
        }
        .navigationTitle(Text("Memes"))
    }
}

struct MemeListView_Previews: PreviewProvider {
    static var previews: some View {
        MemeListView()
    }
}
