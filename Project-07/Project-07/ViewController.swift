//
//  ViewController.swift
//  Project-07
//
//  Created by Yandri Sanchez on 12/13/20.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "info", style: .plain, target: self, action: #selector(dataInfoPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "search", style: .plain, target: self, action: #selector(searchPressed))
        
        var urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                //we're ok to parse
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func searchPressed() {
        let ac = UIAlertController(title: "Search for posts...", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Search", style: .default, handler: { (action) in
            let text = ac.textFields![0].text!
            var tempArray = [Petition]()
            
            for petition in self.petitions {
                if petition.title.lowercased().contains(text.lowercased()) || petition.body.lowercased().contains(text.lowercased()) {
                    tempArray.append(petition)
                }
            }
            
            if !tempArray.isEmpty {
                self.filteredPetitions = tempArray
                self.tableView.reloadData()
            }

        }))
        
        present(ac, animated: true, completion: nil)
    }
    
    @objc func dataInfoPressed() {
        let ac = UIAlertController(title: "This data comes from 'We The People API'", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

