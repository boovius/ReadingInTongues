//
//  TranslationView.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/23/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct TranslationView: View {
  var translation: Translation
  var body: some View {
    HStack {
      Text(translation.from)
      Spacer()
      Text(translation.to)
    }
  }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
      let translation = Translation(from: "hablar", to: "to speak")
      return TranslationView(translation: translation)
    }
}
