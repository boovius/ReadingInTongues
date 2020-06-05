//
//  TranslationViewModel.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 6/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

protocol TranslationViewModelType: ObservableObject {
  var translation: String { get set }
  var word: String { get set }
  var error: Error? { get set }
}

class TranslationViewModel:  TranslationViewModelType {
  @Published var translation: String = ""
  @Published var word: String
  @Published var error: Error?
  private var networkPublisher: NetworkPublisherTranslationsType
  private var subscriptions = Set<AnyCancellable>()

  init(_ word: String,
       networkPublisher: NetworkPublisherTranslationsType = NetworkPublisher(),
       scheduler: DispatchQueue = DispatchQueue(label: "WordTranslation"),
       index: Int,
       respondToWordAndIndex: @escaping (String, Int) -> Void
  ) {
    self.word = word
    self.networkPublisher = networkPublisher

    $word
//      .dropFirst(1) - uncomment this to disable translation upon loading initial word
      // .print() - uncomment this to show the subject is a CurrentValueSubject
      .map { word in
        print("word", word)
        respondToWordAndIndex(word, index)
        return word
      }
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
