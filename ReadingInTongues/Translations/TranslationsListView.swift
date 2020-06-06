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
    List(viewModel.words.indices, id: \.self){ index in
      TranslationView(viewModel: TranslationViewModel(self.viewModel.words[index], index: index, subscriber: self.viewModel)
      )
    }.onAppear(perform: viewModel.loadWords)
  }
}

struct TranslationsListView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = TranslationsListViewModel()
    return TranslationsListView(viewModel: viewModel)
  }
}
