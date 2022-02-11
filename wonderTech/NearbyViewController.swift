



import UIKit
import CoreLocation
import WikipediaKit


class NearbyViewController: UIViewController, CLLocationManagerDelegate {
   
    @IBOutlet weak var imageOne: UIImageView!
    
    @IBOutlet weak var imageTwo: UIImageView!
    
    @IBOutlet weak var imageThree: UIImageView!
    
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var labelTwo: UILabel!
    
@IBOutlet weak var labelThree: UILabel!
    
    var wikiImageURLOne : URL?
    var wikiImageURLTwo : URL?
    var wikiImageURLThree : URL?
   
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        WikipediaNetworking.appAuthorEmailForAPI = "olympiassolutionsllc@gmail.com"
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        imageOne.layer.cornerRadius = 10
        imageOne.clipsToBounds = true
        imageTwo.layer.cornerRadius = 10
        imageTwo.clipsToBounds = true
        imageThree.layer.cornerRadius = 10
        imageThree.clipsToBounds = true
        
        imageOne.layer.borderColor = UIColor.black.cgColor
        imageOne.layer.borderWidth = 1.5
        imageTwo.layer.borderColor = UIColor.black.cgColor
        imageTwo.layer.borderWidth = 1.5
        imageThree.layer.borderColor = UIColor.black.cgColor
        imageThree.layer.borderWidth = 1.5
        
        
     
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print("Locatio: \(location)")
        locationManager.stopUpdatingLocation()
        let language = WikipediaLanguage("en")
        Wikipedia.shared.requestNearbyResults(language: language, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (articlePreviews, language, error) in
            if let articlePreviews = articlePreviews {
                
                
                self.labelOne.text = articlePreviews[0].displayTitle
                self.labelTwo.text = articlePreviews[1].displayTitle
                self.labelThree.text = articlePreviews[2].displayTitle
                    
                let imageWidth = Int(self.view.frame.size.width * UIScreen.main.scale);                Wikipedia.shared.requestArticle(language: language, title: articlePreviews[0].displayTitle, imageWidth: imageWidth, completion: { (article, error) in
                    
                    guard error == nil else { return }
                    guard let article = article else { return }
                
               self.wikiImageURLOne = article.imageURL
                    let imageWidth = Int(self.view.frame.size.width * UIScreen.main.scale);                Wikipedia.shared.requestArticle(language: language, title: articlePreviews[1].displayTitle, imageWidth: imageWidth, completion: { (article, error) in
                        
                        guard error == nil else { return }
                        guard let article = article else { return }
               self.wikiImageURLTwo = article.imageURL


                        
                        let imageWidth = Int(self.view.frame.size.width * UIScreen.main.scale);                Wikipedia.shared.requestArticle(language: language, title: articlePreviews[2].displayTitle, imageWidth: imageWidth, completion: { (article, error) in
                            
                            guard error == nil else { return }
                            guard let article = article else { return }
                         self.wikiImageURLThree = article.imageURL
       
        }
                
            )


}
)
}
)
}
}
        if let url = wikiImageURLOne {
            
            do {
                let data = try Data(contentsOf: wikiImageURLOne!)
                self.imageOne.image = UIImage(data: data)
                
            } catch{
                
            }}
}
}
