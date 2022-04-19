//
//  MemesTableViewController.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 19/04/22.
//

import Foundation
import UIKit

// MARK: - MemesTableViewController: UIViewController
class MemesTableViewController: UIViewController {

  // MARK: Properties
  var memes: [Meme] {
    if let sceneDeleage = UIApplication.shared.delegate as? SceneDelegate {
      return sceneDeleage.memes
    } else {
      return [Meme]()
    }
  }

  // MARK: IBAction
  @IBAction func moveToEditorMeme(_ sender: Any) {
    guard let editorController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeEditorViewController"
    ) as? MemeEditorViewController else { return }

    self.navigationController?.pushViewController(editorController, animated: true)
  }
}

// MARK: - MemesTableViewController: UITableViewDataSource
extension MemesTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.memes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") else { return UITableViewCell() }
    let meme = self.memes[(indexPath as NSIndexPath).row]

    cell.textLabel?.text = "\(String(describing: meme.topText)) ... \(String(describing: meme.bottomText))"
    cell.imageView?.image = meme.memedImage
    return cell
  }
}

// MARK: - MemesTableViewController: UITableViewDelegate
extension MemesTableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    guard let detailController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeDetailViewController"
    ) as? MemeDetailViewController else { return }

    detailController.meme = self.memes[(indexPath as NSIndexPath).row]
    self.navigationController?.pushViewController(detailController, animated: true)
  }
}
