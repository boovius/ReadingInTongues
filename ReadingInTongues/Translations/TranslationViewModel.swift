//
//  TranslationViewModel.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 6/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

class TranslationViewModel: ObservableObject {
  @Published var translation: String = ""
  @Published var word: String
  @Published var error: Error?
  private var networkPublisher: NetworkPublisherTranslationsType
  private var subscriptions = Set<AnyCancellable>()

  init(_ word: String,
       networkPublisher: NetworkPublisherTranslationsType = NetworkPublisher(),
       scheduler: DispatchQueue = DispatchQueue(label: "WordTranslation")
  ) {
    self.word = word
    self.networkPublisher = networkPublisher

    $word
      .dropFirst(1)
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      .sink(receiveValue: translate(word:))
      .store(in: &subscriptions)
  }

  func translate(word: String) {
    _ = networkPublisher.publishTranslation(for: word, to: "en")
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            print("translation completed", completion)
          case .failure(let error):
            print("failure in translation", error)
            self.error = error
          }
      }, receiveValue: { [weak self] response in
        guard let self = self else { return }
        self.translation = response.translations.joined(separator: ", ")
      }
    ).store(in: &subscriptions)
  }
}
