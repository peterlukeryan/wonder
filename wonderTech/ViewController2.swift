

import UIKit
import SwiftSoup
import WikipediaKit
import CoreLocation

class ViewController2: UIViewController {

    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    @IBOutlet weak var didYouKnowText: UILabel!
    
    @IBOutlet weak var artyImage: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    
    var wikiImageURL: URL?

    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        WikipediaNetworking.appAuthorEmailForAPI = "olympiassolutionsllc@gmail.com"
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
       
        artyImage.layer.cornerRadius = 10
        artyImage.clipsToBounds = true
        artyImage.layer.borderColor = UIColor.black.cgColor
        artyImage.layer.borderWidth = 1
        
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
       backView.layer.borderColor = UIColor.black.cgColor
        backView.layer.borderWidth = 1.5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

extension ViewController2 : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print("Locatio: \(location)")
        
        let language = WikipediaLanguage("en")
        Wikipedia.shared.requestNearbyResults(language: language, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (articlePreviews, language, error) in
            if let articlePreviews = articlePreviews {
                
                print(articlePreviews.first!.displayTitle)
             
                
                let imageWidth = Int(self.view.frame.size.width * UIScreen.main.scale);                Wikipedia.shared.requestArticle(language: language, title: articlePreviews.first!.displayTitle, imageWidth: imageWidth, completion: { (article, error) in
                    
                    guard error == nil else { return }
                    guard let article = article else { return }
                  
                    self.wikiImageURL = article.imageURL
                  
               
                    
                    do {
                        
                        let doc =  try SwiftSoup.parse(article.displayText)
                        
                        let element = try doc.select("p").array()
                        
                        var myText = try element[2].text()
                        
                        var backUpText = try element[1].text()
                        
                        print(myText)
                        
                        
                        if myText == "" {
                            self.didYouKnowText.text = backUpText
                        }
                        else {
                        
                            self.didYouKnowText.text = myText }
                     
                        print(location.coordinate.latitude)
                        
                        
                    }catch{
                        
                        
                    }
                    
                })
                
            }
        }
        
        
        if let url = wikiImageURL{
        
        do {
            let data = try Data(contentsOf: wikiImageURL!)
            self.artyImage.image = UIImage(data: data)
        
        } catch{
        
    }
    
}
}
}
