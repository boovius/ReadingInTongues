//
//  JSONSerializationWrapper.swift
//  ReadingInTongues
//
//  Created by Joshua Book on 5/9/20.
//  Copyright © 2020 PagerXYZ. All rights reserved.
//
import Foundation

class JSONSerializationWrapper: JSONSerialization {

  // Taken from https://www.knowband.com/blog/tutorials/read-data-local-json-file-swift/
  static func readJSONFromFile(fileName: String) -> Any?
  {
    var json: Any?
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
      do {
        let fileUrl = URL(fileURLWithPath: path)
        // Getting data from JSON file using the file URL
        let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
        json = try? self.jsonObject(with: data)
      } catch {
        // Handle error here
      }
    }
    return json
  }
}
