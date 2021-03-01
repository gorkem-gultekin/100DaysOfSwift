//
//  ViewController.swift
//  Project16
//
//  Created by Görkem Gültekin on 22.02.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var deneme = [Capital]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", webAddress: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.",webAddress: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", webAddress: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", webAddress: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77036667), info: "Named after George himself.",webAddress: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        mapView.mapType = .hybrid
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView ?? nil
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = .yellow
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else{
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        let placeName = capital.title
        let placeInfo = capital.info
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
        ac.addAction(UIAlertAction(title: "Web Site", style: .default, handler: {_ in
            if let vc = self.storyboard?.instantiateViewController(identifier: "Web") as? Web{
                vc.webAddress = capital.webAddress
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }))
        present(ac, animated: true, completion: nil)
    }
}

