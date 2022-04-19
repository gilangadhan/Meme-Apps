//
//  MemeDetailViewController.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 19/04/22.
//

import UIKit

// MARK: - MemeDetailViewController: UIViewController

class MemeDetailViewController: UIViewController {

  // MARK: Properties
  var meme: Meme!

  // MARK: Outlets
  @IBOutlet weak var imageView: UIImageView!

  // MARK: Life Cycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
    self.imageView!.image = meme.memedImage
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.tabBarController?.tabBar.isHidden = false
  }
}
