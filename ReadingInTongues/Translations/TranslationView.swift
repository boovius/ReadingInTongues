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
    GeometryReader { geometry in
      HStack {
        TextField(self.viewModel.word, text: self.$viewModel.word)
          .background(Color.gray)
          .opacity(0.5)
          .frame(width: geometry.size.width/2)
          .multilineTextAlignment(.center)
          .cornerRadius(5.0)
        Text(self.viewModel.translation)
          .frame(width: geometry.size.width/2)
          .multilineTextAlignment(.center)
      }
    }
  }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = MockTranslationViewModel()
      return TranslationView(viewModel: viewModel)
    }
}
