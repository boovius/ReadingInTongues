//
//  NetworkPublisher+Translations.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import Foundation
import Combine

protocol NetworkPublisherTranslationsType {
  func publishTranslation(for word: String, to target: String) -> AnyPublisher<TranslationResponse, ServerRequestError>
}

extension NetworkPublisher: NetworkPublisherTranslationsType {
  func publishTranslation(for word: String, to target: String) -> AnyPublisher<TranslationResponse, ServerRequestError> {
    let body = ["word":word, "target":target]
    let url =  Config.apiUrl
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
      return Fail(error: ServerRequestError.parsing(message: "Error serializing request body.")).eraseToAnyPublisher()
    }
    request.httpBody = httpBody

    return fetchAndPublish(with: request)
  }
}

