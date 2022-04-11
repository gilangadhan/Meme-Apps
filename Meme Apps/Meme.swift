//
//  Meme.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 11/04/22.
//

import Foundation
import UIKit

// MARK: A model for storing temporary meme data
struct Meme {
  var topText: String? = ""
  var bottomText: String? = ""
  var originalImage: UIImage?
  var memedImage: UIImage?
}
