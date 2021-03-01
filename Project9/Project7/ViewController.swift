//
//  ViewController.swift
//  Project7
//
//  Created by Görkem Gültekin on 8.02.2021.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString:String
        if self.navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            if let url = URL(string: urlString){
                if let data = try? Data(contentsOf: url){
                    self?.parse(json: data)
                    return
                }
            }
            self?.showError()
        }
        
    }
    func showError() {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading Error", message: "hata mesajı", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    func parse (json:Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

