//
//  TranslationsListViewModel.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine

class TranslationsListViewModel: ObservableObject {
//  typealias Input = String
//
//  typealias Failure = Never

  private var cancellable: AnyCancellable?
  @Published var words: [String] = []
  @Published var error: Error?

  // TODO: see if this the callback stuff below can get moved into this subscription stuff here
//  func receive(subscription: Subscription) {
//    subscription.request(.unlimited)
//  }
//
//  func receive(_ input: String) -> Subscribers.Demand {
//    print("Received value", input)
//    return .none
//  }
//
//  func receive(completion: Subscribers.Completion<Never>) {
//    print("Received Completion", completion)
//  }

  func updateWords(with word: String, at index: Int) {
    if (words[index] != word) {
      words[index] = word
    }
    if (index + 1 == words.count && word != "") {
      words.append("")
    }
  }
}

// MARK: - data source methods
extension TranslationsListViewModel {
  func loadWords() {
    error = nil
    do {
      if let file = Bundle.main.url(forResource: "words-data", withExtension: "json") {
        let data = try Data(contentsOf: file)
        let words = try JSONDecoderWrapper().decode([String].self, from: data)
        cancellable = Just(words)
          .receive(on: DispatchQueue.main)
          .sink(
            receiveCompletion: { [weak self] completion in
              guard let self = self else { return }
              switch completion {
              case .failure(let error):
                print("Failure loading words: \(error)")
                self.error = error
              case .finished:
                print("Finished receiving words.")
              }

            },
            receiveValue: { [weak self] words in
              guard let self = self else { return }
              var updatedWords = words
              self.appendEmptyWord(to: &updatedWords)
              self.words = updatedWords
          })
      }
    } catch {
      self.error = error
    }
  }

  private func appendEmptyWord(to words: inout [String]) {
    if (words[words.count - 1] != "") {
      words.append("")
    }
  }
}
