//
//  MapViewController.swift
//  Maps
//
//  Created by Юлия Филимонова on 08.08.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

final class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    private let locationManager = CLLocationManager()
    private let network = NetworkingManager()
    private var dataModel: DataModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

 //      Получение и передача данных из сети в контроллер
        network.getData()
        network.getPointLine = {[weak self] result in
            guard let self = self else { return }
            self.dataModel = result
        }
    }

    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        //Настройка камеры, для обзора, полученных данных.
        mapView.camera = GMSCameraPosition.camera(withLatitude: 49.0686803349595, longitude: 9.76386740188363, zoom: 17.0) //Подразумевается, что симулятор настроен на данные широту и долготу. В таком случае данная строка кода не нужна.

        guard let data = dataModel else { return }
        // Расположение точек
        for data in data.points {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: data.properties.latitude, longitude: data.properties.longitude)
            marker.title = data.properties.name
            marker.map = mapView
        }
        // Расположение линий
        for data in data.lines {
            let path = GMSMutablePath()
            let coordinates = data.geometry.coordinates

            for coordinate in coordinates {
                let longitude = coordinate[0]
                let latitude = coordinate[1]
                path.add(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
            let line = GMSPolyline(path: path)
            line.strokeColor = UIColor.blue
            line.strokeWidth = 3.0
            line.map = mapView
        }
    }

}


//MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    // Дефолтная локация по месту, которое определяет телефон
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinate = location.coordinate
        mapView.camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 17.0)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.icon = GMSMarker.markerImage(with: UIColor.green)
        marker.title = "Hi, it's me!"
        marker.map = mapView
    }

}


