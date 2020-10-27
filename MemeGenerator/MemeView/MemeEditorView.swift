//
//  MemeEditorView.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/26/20.
//

import SwiftUI

struct MemeEditorView: View {
    let meme: Meme.Info

    @State private var addedLabels: [String]

    init(from meme: Meme.Info) {
        self.meme = meme
        self._addedLabels = State(initialValue: Array.init(repeating: "", count: meme.boxCount ?? 0))
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                AsyncImage(url: URL(string: meme.url!)!, placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                })
                .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.height / 2.5)
                .padding(.horizontal)

                ForEach(addedLabels, id: \.self) { label in
                    MemeEditorDraggableLabel(text: label)
                }
            }

            ForEach(0..<(meme.boxCount ?? 0)) { i in
                TextField("Label \(i + 1)", text: $addedLabels[i])
                    .padding(.leading)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 35)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(10)

            }.padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle(meme.name ?? "Meme", displayMode: .inline)
    }
}

struct MemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        MemeEditorView(from: .fakeMeme)
    }
}
