//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Yandri Sanchez on 11/2/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        if let formattedName = imageName {
            title = formattedName.components(separatedBy: "@3x")[0].uppercased()
   
        }
        imageView.image = UIImage(named: imageName!)
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        
    }
    
    @objc func shareTapped() {
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
       
    }

}
