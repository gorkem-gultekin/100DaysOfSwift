//
//  ViewController.swift
//  Project13
//
//  Created by Görkem Gültekin on 17.02.2021.
//

import UIKit
import CoreImage
class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var intensity: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "YACIFP"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    @objc func importPicture(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true, completion: nil)
        currentImage = image
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    func applyProcessing(){
        guard let image = currentFilter.outputImage else{return}
        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        if let cgimg = context.createCGImage(image, from: image.extent){
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey){currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey){currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)}
        if inputKeys.contains(kCIInputCenterKey){currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)}
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent){
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
        
    }

    @IBAction func changeFilter(_ sender: Any) {
        let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
        
    }
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else {return}
        guard let actionTitle = action.title else {return}
        currentFilter = CIFilter(name: actionTitle)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
}

