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
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      return appDelegate.memes
    } else {
      return [Meme]()
    }
  }

  // MARK: IBOutlet
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var emptyScreen: UIView!

  // MARK: IBAction
  @IBAction func moveToEditorMeme(_ sender: Any) {
    guard let editorController = self.storyboard?.instantiateViewController(
      withIdentifier: "MemeEditorViewController"
    ) as? MemeEditorViewController else { return }

    self.navigationController?.pushViewController(editorController, animated: true)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if memes.isEmpty {
      emptyScreen.isHidden = false
      tableView.isHidden = true
    } else {
      emptyScreen.isHidden = true
      tableView.isHidden = false
      tableView?.reloadData()
    }
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

    cell.textLabel?.text = "\(meme.topText ?? "TOP")"
    cell.imageView?.image = meme.memedImage

    if let detailTextLabel = cell.detailTextLabel {
        detailTextLabel.text = "\(meme.bottomText ?? "BOTTOM")"
    }
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
