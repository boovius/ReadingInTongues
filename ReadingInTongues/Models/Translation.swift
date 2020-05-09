//
//  Photo.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation

struct TranslationResponse: Decodable {
  var data: [Translation]
}

struct Translation: Hashable, Identifiable, Decodable {
  var id: UUID?
  var from: String
  var to: String
}
