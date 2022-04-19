//
//  MemeCollectionViewController.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 12/04/22.
//

import Foundation
import UIKit

// MARK: - MemesCollectionViewController: UICollectionViewController
class MemesCollectionViewController: UIViewController {

  // MARK: Properties
  var memes: [Meme] {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      return appDelegate.memes
    } else {
      return [Meme]()
    }
  }

  // MARK: IBOutlet
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  @IBOutlet var emptyScreen: UIView!
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    let space: CGFloat = 3.0
    let dimension = (view.frame.size.width - (2 * space)) / 3.0

    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if memes.isEmpty {
      collectionView.isHidden = true
      emptyScreen.isHidden = false
    } else {
      emptyScreen.isHidden = true
      collectionView.isHidden = false
      collectionView.reloadData()
    }
  }

  // MARK: IBACtion
  @IBAction func moveToEditorMeme(_ sender: Any) {
    guard let editorController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeEditorViewController"
    ) as? MemeEditorViewController else { return }
    self.navigationController?.pushViewController(editorController, animated: true)
  }
}

extension MemesCollectionViewController: UICollectionViewDataSource {
  // MARK: Collection View Data Source
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return self.memes.count
  }

  // MARK: Collection ViewCell
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "MemeCollectionViewCell",
      for: indexPath
    ) as? MemeCollectionViewCell else { return UICollectionViewCell() }
    let meme = self.memes[(indexPath as NSIndexPath).row]

    cell.memeImageView?.image = meme.memedImage

    return cell
  }
}

extension MemesCollectionViewController: UICollectionViewDelegate {

  // MARK: Collection View Delegate
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let detailController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeDetailViewController"
    ) as? MemeDetailViewController else { return }

    detailController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }
}
