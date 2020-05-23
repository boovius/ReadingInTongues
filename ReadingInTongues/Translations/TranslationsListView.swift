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
    NavigationView {
      Group {
        if viewModel.error != nil {
          ErrorWithRetryView(text: "Error: \(viewModel.error!.localizedDescription)", action: viewModel.loadTranslations)
        } else {
          List {
            Section(footer: NavToAddWord()) {
              ForEach(viewModel.translations) { translation in
                    TranslationView(translation: translation)
              }
            }
          }
        }
      }.onAppear(perform: self.viewModel.loadTranslations)
    }
  }
}

struct NavToAddWord: View {
  var body: some View {
    NavigationLink(destination: AddTranslationView()) {
      Button(action: {}) { Text("Add Word") }
    }.buttonStyle(PlainButtonStyle())
  }
}

struct TranslationsListView_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = TranslationsListViewModel()
    return TranslationsListView(viewModel: viewModel)
  }
}
