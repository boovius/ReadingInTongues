//
//  AddTranslationView.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/23/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//

import SwiftUI

struct AddTranslationView: View {
  @State private var newWord: String = ""
  var body: some View {
    NavigationView {
      VStack {
        TextField("new word", text: $newWord, onCommit: { print("committed")})
        Button(action: {
          print("I am submitting word")
        }) {
          Text("Add")
        }
      }.navigationBarTitle("Add Translation")
    }
  }
}

struct AddTranslationView_Previews: PreviewProvider {
    static var previews: some View {
        AddTranslationView()
    }
}
