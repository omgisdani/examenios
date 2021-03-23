//
//  Movie.swift
//  examenIOS
//
//  Created by pekxel ara on 22/03/21.
//

import Foundation

struct PelisResponse: Decodable {
    let results: [Peli]
}
struct Peli: Decodable {
 
    let id: Int
    let title: String
    let img: String
    let date: String
    let description: String
}

