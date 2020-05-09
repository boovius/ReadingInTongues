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
  func publishTranslations() -> AnyPublisher<TranslationResponse, ServerRequestError>
}

extension NetworkPublisher: NetworkPublisherTranslationsType {
  func publishTranslations() -> AnyPublisher<TranslationResponse, ServerRequestError> {
    let url =  Config.apiUrl.appendingPathComponent("api/v1/translations")
    return fetchAndPublish(from: url)
  }
}

