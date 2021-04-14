//
//  ViewController.swift
//  Project-PartB
//
//  Created by Drill on 28/11/20.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var faveBtn: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var apiTitle : String!
    var apiType : String!
    var apiRarity : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide faveBtn
        self.faveBtn.isHidden = true
        // Rounded corners
        searchButton.layer.cornerRadius = 25
        searchButton.layer.masksToBounds = true
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        // Show faveBtn
        self.faveBtn.isHidden = false
        print("Searching might take a while...")
        
        // API Search URL
        let apiString = "https://api.magicthegathering.io/v1/cards?subtypes=elf&gameFormat=modern"
        let apiURL = URL(string: apiString)
        let apiRequest = URLRequest(url: apiURL!)
        let task = URLSession.shared.dataTask(with: apiRequest) {
            (data,response,error)
            in
            
            if (error == nil) {
                let jasonData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let cards =  jasonData["cards"] as! [[String:Any]]
                let random = Int(arc4random_uniform((UInt32)(cards.count)))
                
                self.apiTitle = cards[random]["name"] as! String
                self.apiType = cards[random]["type"] as! String
                self.apiRarity = cards[random]["rarity"] as! String
                let imageString = cards[random]["imageUrl"] as! String
                //For possible nested array
                //let resultsImg = results[random]["imageUrl"] as! [String: Any], imgUrl = resultsImg["thumb"] as! String
                let imageURL = URL(string: imageString)
                
                // Have to change image URL to HTTPS for some server reasons
                var http = URLComponents(url: imageURL!, resolvingAgainstBaseURL: false)!
                http.scheme = "https"
                let https = http.url!
                
                DispatchQueue.main.async {
                    let picData = try! Data(contentsOf: https)
                    let image = UIImage(data: picData)
                    self.imageView.image = image
                    //print("image")
                    //print("title \(self.apiTitle)")
                }
                
            } else {
                print("API error")
            }
            
        }
        
        task.resume()
        
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let apiData = NSEntityDescription.insertNewObject(forEntityName: "ApiData", into: context) as! ApiData
        apiData.title = apiTitle
        apiData.type = apiType
        apiData.rarity = apiRarity
        apiData.image = imageView.image?.pngData()
        
        do {
            try context.save()
            performSegue(withIdentifier: "showCards", sender: self)
            print("Data added successfully")
        }
        
        catch {
            print("Data insertion error")
        }
        
    }
    
}


