//
//  TranslationView.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/23/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

// Genericized viewModel: https://stackoverflow.com/questions/59503399/how-to-define-a-protocol-as-a-type-for-a-observedobject-property

struct TranslationView<ViewModel>: View where ViewModel: TranslationViewModelType {
  @ObservedObject var viewModel: ViewModel

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
      let viewModel = MockTranslationViewModel()
      return TranslationView(viewModel: viewModel)
    }
}
