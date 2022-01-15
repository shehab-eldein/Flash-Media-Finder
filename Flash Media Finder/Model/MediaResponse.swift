//
//  MediaResponse.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 23/11/2021.
//

import Foundation
struct MediaRespone: Codable {
    var  resultCount: Int
    var results: [Media]
}
