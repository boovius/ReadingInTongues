//
//  TranslationView.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/23/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct TranslationView: View {
  @ObservedObject var viewModel: TranslationViewModel
  var body: some View {
    HStack {
      TextField(viewModel.word, text: $viewModel.word)
      Spacer()
      Text(viewModel.translation)
    }
  }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = TranslationViewModel("hablar")
      return TranslationView(viewModel: viewModel)
    }
}
