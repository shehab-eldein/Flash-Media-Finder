//  ViewController.swift
//  Flash Media Finder
//
//  Created by shehab ahmed on 18/10/2021.
//
import UIKit
import MapKit
//MARK:- Protocol
protocol mapAddressDelegate: class {
    func sendAdress(address: String)
}
class MapVC: UIViewController {
    //MARK:- OutLets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adressLabel: UILabel!
    //MARK:- Properties
    let locationManager = CLLocationManager ()
    weak var delegate: mapAddressDelegate?
    //MARK:- LifeCycleMethod
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationSetting()
    }
    //MARK:- Actions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        if let address = adressLabel.text {
            delegate?.sendAdress(address: address)
            dismiss(animated: true, completion: nil)
        } else {
            print("can't catch the address")
        }
    }
}
//MARK:- Private Map Method
extension MapVC : MKMapViewDelegate {
    private func getHardCodeLocation() {
        let location = CLLocation(latitude: 27.180134, longitude: 31.189283)
        let region   = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        self.getTheLocationName(location: location)
    }
    private func checkLocationSetting() {
        if CLLocationManager.locationServicesEnabled() {
            authorizationCases()
        } else {
            print("location Service is Disable")
        }
    }
    private func authorizationCases () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,.authorizedWhenInUse:
            getHardCodeLocation()
        case .denied ,.restricted:
            print("please access the location to use")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("unknown Case")
        }
    }
    private func getTheLocationName (location: CLLocation) {
        let geoCoder = CLGeocoder ()
        geoCoder.reverseGeocodeLocation(location) { (Placemark, Error) in
            if let error = Error {
                print("GeoCoder Error\(error.localizedDescription)")
            }
            if let haveValue = Placemark {
                self.HandelPlaceMark(placeMark: haveValue)
            }
        }
    }
    private func HandelPlaceMark (placeMark: [CLPlacemark]){
        if let firstPlace  = placeMark.first {
            if let country = firstPlace.country ,
               let local   = firstPlace.locality,
               let subLoc  = firstPlace.subLocality,
               let throu   = firstPlace.thoroughfare {
                let details = "\(country),\(local),\(subLoc),\(throu)"
                print(details)
                adressLabel.text = details
            }
        }
    }
}
//MARK:- Map Delegate Method
extension MapVC {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
       let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        self.getTheLocationName(location: location)
    }
}
