//
//  DetailViewController.swift
//  Picture-Perfect
//
//  Created by Yandri Sanchez on 12/30/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageCaption: UILabel!
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = picture {
            let path = getDocumentsDirectory().appendingPathComponent(imageToLoad.image)
            imageView.image  = UIImage(contentsOfFile: path.path)
            imageCaption.text = imageToLoad.caption
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
