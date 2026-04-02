//
//  Breed.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/04/02.
//

import Foundation

struct Breed: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let temperament: String?
    let origin: String?
}
