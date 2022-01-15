//
//  MediaModel.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 23/11/2021.
//

import Foundation
struct Media: Codable {
    var artistName: String?
    var trackName: String?
    var longDescription: String?
    var previewUrl: String?
    var artworkUrl100: String?
}
