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
  @Published var translations: [Translation] = []
  @Published var error: Error?
}

// MARK: - data source methods
extension TranslationsListViewModel {
  func loadTranslations() {
    error = nil
    do {
      if let file = Bundle.main.url(forResource: "translations", withExtension: "json") {
        let data = try Data(contentsOf: file)
        let translations = try JSONDecoderWrapper().decode([Translation].self, from: data)
        cancellable = Just(translations)
          .receive(on: DispatchQueue.main)
          .sink(
            receiveCompletion: { [weak self] completion in
              guard let self = self else { return }
              switch completion {
              case .failure(let error):
                print("Failure loading Translations: \(error)")
                self.error = error
              case .finished:
                print("Finished receiving Translations.")
              }

            },
            receiveValue: { [weak self] translations in
              guard let self = self else { return }
              self.translations = translations
          })
      }
    } catch {
      self.error = error
    }

  }
}
