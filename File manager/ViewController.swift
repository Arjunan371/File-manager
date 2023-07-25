//
//  ViewController.swift
//  File manager
//
//  Created by Mohammed Abdullah on 14/07/23.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController,UIDocumentPickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var selectedImages: [UIImage] = []
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = ""
        label2.text = ""
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.size.width/4
    }
    @objc func tappedMe()
    {
      

        showFilePicker()
        print("tapped on me")
    }
    
 /*   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
          
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    } */
    func showFilePicker() {
            let filePicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeImage)], in: .import)
            filePicker.delegate = self
            filePicker.allowsMultipleSelection = false

            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [String(kUTTypeImage)]

            let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "File Manager", style: .default, handler: { _ in
                self.present(filePicker, animated: true, completion: nil)
            }))
            alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                self.present(imagePicker, animated: true, completion: nil)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            present(alertController, animated: true, completion: nil)
        }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else {
            print("No URL selected")
            return
        }
        let fileName = selectedURL.deletingPathExtension().lastPathComponent
            let fileType = selectedURL.pathExtension.uppercased()
        label1.text = fileName
        label2.text = fileType
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: selectedURL)
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self.imageView.image = image
                    } else {
                        print("Failed to create image from data")
                    }
                }
            } catch {
                print("Error loading image data: \(error)")
            }
        }
    }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            picker.dismiss(animated: true, completion: nil)

            if let image = info[.originalImage] as? UIImage {
                imageView.image = image
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
  
   


