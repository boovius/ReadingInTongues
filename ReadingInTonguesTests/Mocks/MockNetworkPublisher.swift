//
//  MockNetworkPublisher.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/8/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Combine

class MockNetworkPublisher: NetworkPublisherTranslationsType {
  private let translationResponse: TranslationResponse
  init(translationResponse: TranslationResponse) {
    self.translationResponse = translationResponse
  }

  func publishTranslation(for word: String, to target: String) -> AnyPublisher<TranslationResponse, ServerRequestError> {
    Just(translationResponse)
      .mapError { error in ServerRequestError.serverError(message: "oops") }
      .eraseToAnyPublisher()
  }
}
