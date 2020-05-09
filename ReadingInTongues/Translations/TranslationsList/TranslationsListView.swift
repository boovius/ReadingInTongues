//
//  TranslationListView.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/4/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIPullToRefresh

struct TranslationsListView: View {
  @ObservedObject var viewModel: TranslationsListViewModel

  init(viewModel: TranslationsListViewModel = TranslationsListViewModel()) {
    self.viewModel = viewModel
  }

  var body: some View {
    Group {
      if viewModel.error != nil {
        ErrorWithRetryView(text: "Error: \(viewModel.error!.localizedDescription)", action: viewModel.loadTranslations)
      } else {
        List(viewModel.translations, id: \.self) { translation in
          HStack {
            Text(translation.from)
            Spacer()
            Text(translation.to)
          }
        }
      }
    }.onAppear(perform: self.viewModel.loadTranslations)
  }
}

struct TranslationsListView_Previews: PreviewProvider {

  static var previews: some View {
    return TranslationsListView()
  }
}
