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
  private var cancellable: AnyCancellable?
  @Published var words: [String] = []
  @Published var error: Error?
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
              self.words = words
          })
      }
    } catch {
      self.error = error
    }

  }
}
