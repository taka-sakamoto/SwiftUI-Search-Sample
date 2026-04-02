//
//  Cat.swift
//  SwiftUI-Search-Sample
//
//  Created by Takayuki Sakamoto on 2026/03/16.
//

import SwiftUI
import Foundation

struct Cat: Codable, Identifiable, Equatable {
    let id: String
    let url: String
    let breeds: [Breed]?
}

/*
#Preview {
    Cat()
}
*/
