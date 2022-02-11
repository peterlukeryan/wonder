//
//  ViewController.swift
//  wonderTech
//
//  Created by Mac User on 6/21/18.
//  Copyright © 2018 Mac User. All rights reserved.
//

import UIKit
import SwiftSoup
import WikipediaKit
import CoreLocation

class ViewController: UIViewController {
    
   
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
   
    @IBOutlet weak var articleTitleText: UILabel!
    
    @IBOutlet weak var imageBlur: UIVisualEffectView!
    @IBOutlet weak var articlePreviewText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
   
    var image: UIImage?
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        WikipediaNetworking.appAuthorEmailForAPI = "olympiassolutionsllc@gmail.com"
       
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
       
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        imageView.image = image
        imageBlur.layer.borderColor = UIColor.black.cgColor
        imageBlur.layer.borderWidth = 1
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        self.articlePreviewText.isHidden = true
        self.imageBlur.isHidden = true
        
        
    }
    
    
}





extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        if location.horizontalAccuracy < 0 {
            self.articleTitleText.text = "Loading..."
        }
        if location.horizontalAccuracy > 80{
            self.articleTitleText.text = "Please wait, loading..."
        }
        if location.horizontalAccuracy < 10{
            locationManager.stopUpdatingLocation()
            
        }
        
        print("Locatio: \(location)")
        
        let language = WikipediaLanguage("en")
        Wikipedia.shared.requestNearbyResults(language: language, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (articlePreviews, language, error) in
            if let articlePreviews = articlePreviews {
                
                print(articlePreviews.first!.displayTitle)
                self.articleTitleText.text = articlePreviews.first!.displayTitle
                
                let imageWidth = Int(self.view.frame.size.width * UIScreen.main.scale);                Wikipedia.shared.requestArticle(language: language, title: articlePreviews.first!.displayTitle, imageWidth: imageWidth, completion: { (article, error) in
                    
                    guard error == nil else { return }
                    guard let article = article else { return }
                    
                   
                    
                    
                    
                    do {
                        
                        let doc =  try SwiftSoup.parse(article.displayText)
                        
                        let element = try doc.select("p").array()
                        
                        var myText = try element[0].text()
                        var backUpText = try element[1].text()
                        
                        print(myText)
                        
                        if myText == ""{
                            
                            self.articlePreviewText.text = backUpText
                        }
                        else {
                            self.articlePreviewText.text = myText
                        }
                        
                    }catch{
                        
                        
                    }
                    
                })
                
            }
        }
        
        
      
                
            }
            
        }
    

