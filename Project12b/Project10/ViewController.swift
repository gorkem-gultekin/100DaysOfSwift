//
//  ViewController.swift
//  Project10
//
//  Created by Görkem Gültekin on 10.02.2021.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data{
            let jsonDecoder = JSONDecoder()
            do{
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
            }catch{
                print("Failed to load people")
            }
        }
    }
    @objc func addNewPerson(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        let person = Person(name: "Unknown", imageName: imageName)
        people.append(person)
        save()
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    func save(){
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(people){
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: "people")
        }else{
            print("Failed to save people")
        }
    }
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("unable to dequeue personcell")
        }
        let person = people[indexPath.row]
        cell.name.text = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 20
        cell.layer.cornerRadius = 20
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else {return}
            person.name = newName
            self?.save()
            self?.collectionView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Delete", style: .default) {_ in
            self.people.remove(at: indexPath.row)
            self.collectionView.reloadData()
        })
        present(ac, animated: true, completion: nil)
    }


}

