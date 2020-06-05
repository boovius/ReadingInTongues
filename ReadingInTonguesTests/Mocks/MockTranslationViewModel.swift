//
//  MockTranslationViewModel.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 6/5/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

class MockTranslationViewModel:  TranslationViewModelType {
  @Published var word: String
  @Published var translation: String
  @Published var error: Error?

  init(word: String = "hablar", translation: String = "speak", error: Error? = nil) {
    self.word = word
    self.translation = translation
    self.error = error
  }
}

//class MockTranslationViewModel: ObservableObject, TranslationViewModelType {
//  @Published var translation: String
//  @Published var word: String
//  @Published var error: Error?
//
//  init(word: String = "hablar", translation: String = "speak", error: Error?)
//  ) {
//    self.word = word
//    self.translation = translation
//    self.error = error
//  }
//}
