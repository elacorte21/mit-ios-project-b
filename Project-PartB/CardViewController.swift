//
//  CardViewController.swift
//  Project-PartB
//
//  Created by Drill on 1/12/20.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var picView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = card.title
        typeLabel.text =  card.type
        rarityLabel.text =  card.rarity
        let picData = card.image
        picView.image = UIImage(data: picData!)
    }

}
