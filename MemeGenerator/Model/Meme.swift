//
//  Meme.swift
//  MemeGenerator
//
//  Created by Brandon Baars on 10/23/20.
//

import Foundation
import Combine

struct Meme: Codable {
    let success: Bool
    let data: Meme.Data
}

extension Meme {
    struct Data: Codable {
        let memes: [Meme.Info]
    }
}

extension Meme {
    struct Info: Codable, Hashable {
        let id: String?
        let name: String?
        let url: String?
        let width: Int?
        let height: Int?
        let boxCount: Int?
    }
}

extension Meme.Info {
    static var fakeMeme = Meme.Info(id: "1",
                                    name: "one does not simply",
                                    url: "https://i.imgflip.com/1bij.jpg",
                                    width: 200,
                                    height: 300,
                                    boxCount: 2)
}


