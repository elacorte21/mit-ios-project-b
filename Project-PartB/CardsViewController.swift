//
//  CardsViewController.swift
//  Project-PartB
//
//  Created by Drill on 28/11/20.
//

import UIKit
import CoreData

var card : ApiData!

class CardsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var apiData = [ApiData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let del = UIApplication.shared.delegate as! AppDelegate
        let context = del.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "ApiData")
        apiData = try! context.fetch(request) as! [ApiData]
        // Page title
        title = "My Elf Cards"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CardsTableViewCell
        cell.titleLabel.text = apiData[indexPath.row].title
        cell.typeLabel.text = apiData[indexPath.row].type
        cell.rarityLabel.text = apiData[indexPath.row].rarity
        let picData = apiData[indexPath.row].image
        cell.picView.image = UIImage(data: picData!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        card = apiData[indexPath.row]
        performSegue(withIdentifier: "showCard", sender: self)
    }
    

}
