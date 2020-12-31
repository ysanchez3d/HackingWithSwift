//
//  ViewController.swift
//  Product1
//
//  Created by Yandri Sanchez on 10/22/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(fetchImages), with: nil)
        
        if let savedPictures = UserDefaults.standard.object(forKey: "pictures") as? Data {
            let decoder = JSONDecoder()
            if let loadedPictures = try? decoder.decode([Picture].self, from: savedPictures) {
                pictures = loadedPictures
            }
        }
    }
    
    @objc func fetchImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                let picture = Picture(name: item)
                pictures.append(picture)
            }
        }
        pictures = pictures.sorted(by: { $0.name > $1.name })
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "pictures")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].name
        cell.detailTextLabel?.text = "Total Views: \(String(pictures[indexPath.row].views))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].name
            vc.pictureNum = indexPath.row + 1
            vc.totalPictures = pictures.count
            pictures[indexPath.row].views += 1
            tableView.reloadData()
            save()
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

