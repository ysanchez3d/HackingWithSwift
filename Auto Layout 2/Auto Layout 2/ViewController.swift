//
//  ViewController.swift
//  Auto Layout 2
//
//  Created by Yandri Sanchez on 12/1/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        //the commentend approach uses VFL: Visual Format language
        //let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        //this approach uses anchors
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

            //makes height of labels 1/5 of the safe area -10 points they have in-between.
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
          
            if let previous = previous {
                //adss 10points separation to all exept first
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                //this is the first label
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true

            }
            
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
        
        
        for label in [label1, label2, label3, label4, label5] {
            print(label.frame.height)
        }
            
        
    }


}

