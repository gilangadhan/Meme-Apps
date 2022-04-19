//
//  ViewController.swift
//  Meme Apps
//
//  Created by Gilang Ramadhan on 07/04/22.
//

import UIKit

class MemeEditorViewController: UIViewController {

  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var imagePickerView: UIImageView!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!

  // MARK: Subscribe keyboard notification, call the setTextField, and make sure that the camera feature is available.
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    subscribeToKeyboardNotifications()

    setTextField(textField: topTextField, defaultText: "TOP")
    setTextField(textField: bottomTextField, defaultText: "BOTTOM")
  }

  // MARK: Unsubscribe keyboard notification.
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unSubscribeToKeyboardNotifications()
  }

  // MARK: Go To Previous View Controller
  @IBAction func goBack(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  // MARK: Get pictures from photo library or camera.
  @IBAction func pickAnImage(_ sender: UIButton) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    if sender.tag == 0 {
      imagePicker.sourceType = .photoLibrary
    } else {
      imagePicker.sourceType = .camera
    }
    present(imagePicker, animated: true, completion: nil)
  }

  // MARK: Save and share memes.
  @IBAction func shareMeme(_ sender: Any) {
    let acitivityController = UIActivityViewController(
      activityItems: [generateMemedImage()],
      applicationActivities: nil
    )
    acitivityController.completionWithItemsHandler = { _, success, _, _ in
      if success {
        self.save()
      }
    }
    present(acitivityController, animated: true, completion: nil)
  }

  // MARK: Delete image and rearrange text in textfield.
  @IBAction func removePicture(_ sender: Any) {
    imagePickerView.image = UIImage(named: "PlaceHolder")
    topTextField.text = "TOP"
    bottomTextField.text = "BOTTOM"
  }

  // MARK: Set the appearance of the TextField.
  func setTextField(textField: UITextField, defaultText: String) {
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
      .strokeColor: UIColor.black,
      .foregroundColor: UIColor.white,
      .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      .strokeWidth: -3
    ]

    textField.defaultTextAttributes = memeTextAttributes
    textField.text = defaultText
    textField.textAlignment = .center
  }
}

// MARK: Extend UIImagePickerControllerDelegate and UINavigationControllerDelegate to ViewController
extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  // MARK: Closes gallery if cancel.
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }

  // MARK: Display the selected image result to UIImageView
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    var newImage: UIImage

    if let possibleImage = info[.editedImage] as? UIImage {
      newImage = possibleImage
    } else if let possibleImage = info[.originalImage] as? UIImage {
      newImage = possibleImage
    } else {
      return
    }

    imagePickerView.image = newImage

    dismiss(animated: true, completion: nil)
  }

  // MARK: Saves the image after the user has finished creating the meme.
  func save() {
    if imagePickerView.image != nil && topTextField.text != nil && bottomTextField.text != nil {
      let meme = Meme(
        topText: topTextField.text,
        bottomText: bottomTextField.text,
        originalImage: imagePickerView.image,
        memedImage: generateMemedImage()
      )

      guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else { return }
      appDelagate.memes.append(meme)

      navigationController?.popViewController(animated: true)
    } else {
      print("Faile to save")
    }
  }

  // MARK: Generate ready-made meme images along with their text.
  func generateMemedImage() -> UIImage {
    navigationController?.isToolbarHidden = true
    navigationController?.isNavigationBarHidden = true

    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    navigationController?.isToolbarHidden = false
    navigationController?.isNavigationBarHidden = false

    return memedImage
  }

}

// MARK: Extend UITextFieldDelegate to ViewController
extension MemeEditorViewController: UITextFieldDelegate {

  // MARK: Delete text field text when edited.
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if topTextField.text == "TOP" || bottomTextField.text == "BOTTOM" {
        textField.text = ""
    }
  }

  // MARK: Hide the keyboard by going back.
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }

  // MARK: Hide keyboard with one click from text.
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }

  // MARK: Show keyboard.
  @objc func keyboardWillShow(_ notification: Notification) {
    if bottomTextField.isFirstResponder && view.frame.origin.y == 0.0 {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }

  // MARK: Hide keyboard.
  @objc func keyboardWillHide(_ notification: Notification) {
    if bottomTextField.isFirstResponder {
        view.frame.origin.y = 0
    }
  }

  // MARK: Get keyboard height.
  func getKeyboardHeight(_ notification: Notification) -> CGFloat {
    let userInfo = notification.userInfo
    guard let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return 0 }
    return keyboardSize.cgRectValue.height
  }

  // MARK: Create a subscriber to monitor the movement of the keyboard.
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow(_:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide(_:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }

  // MARK: Create a function to remove all the observers.
  func unSubscribeToKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self)
  }

}
