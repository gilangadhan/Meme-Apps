//
//  MemeCollectionViewController.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 12/04/22.
//

import Foundation
import UIKit

// MARK: - MemesCollectionViewController: UICollectionViewController
class MemesCollectionViewController: UICollectionViewController {

  // MARK: Properties
  var memes: [Meme] {
    if let sceneDeleage = UIApplication.shared.delegate as? SceneDelegate {
      return sceneDeleage.memes
    } else {
      return [Meme]()
    }
  }

  // MARK: IBOutlet
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    let space: CGFloat = 3.0
    let dimension = (view.frame.size.width - (2 * space)) / 3.0

    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }

  // MARK: Collection View Data Source
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return self.memes.count
  }

  // MARK: Collection ViewCell
  override func collectionView(
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

  // MARK: Collection View Delegate
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let detailController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeDetailViewController"
    ) as? MemeDetailViewController else { return }

    detailController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController!.pushViewController(detailController, animated: true)

  }

  // MARK: IBACtion
  @IBAction func moveToEditorMeme(_ sender: Any) {
    guard let editorController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeEditorViewController"
    ) as? MemeEditorViewController else { return }
    self.navigationController?.pushViewController(editorController, animated: true)
  }
}
