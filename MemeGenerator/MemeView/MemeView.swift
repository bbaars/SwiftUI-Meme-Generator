//
//  MemeView.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/23/20.
//

import SwiftUI

struct MemeView: View {
    let meme: Meme.Info

    var body: some View {
        AsyncImage(url: URL(string: meme.url ?? "https://i.imgflip.com/1bij.jpg")!) {
            RoundedRectangle(cornerRadius: 0)
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: UIScreen.main.bounds.width - 32,
               height: 350)
        .overlay(
            Text(meme.name ?? "")
                .bold()
                .font(.system(size: 27,
                              weight: .bold,
                              design: .rounded))
                .foregroundColor(Color.white)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.bottom, 10)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.75), Color.clear]),
                                   startPoint: .bottom,
                                   endPoint: .top)
                ), alignment: .bottom
        )
        .cornerRadius(20)
        .padding(.vertical)
    }
}

struct MemeView_Previews: PreviewProvider {
    static var previews: some View {
        MemeView(meme: .fakeMeme)
    }
}
