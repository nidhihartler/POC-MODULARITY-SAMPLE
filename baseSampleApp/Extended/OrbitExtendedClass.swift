//
//  OrbitExtendedClass.swift
//  baseSampleApp
//
//  Created by Nidhi Gupta on 28/05/17.
//  Copyright © 2017 Nidhi Gupta. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

class OrbitExtendedClass: BaseViewController{
    var orbitBarView            : OrbitView?
    var undoDeleteBarView       : UndoDeleteView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addTopView()
        self.addRightView()
        // Here Bottom view is not require from base class
        addOrbitView()
        self.mgMapView?.delegate = self
    }
    
    override func onRightButtonAction() {
        topBarView?.descriptionText.text = "Right Extended Action called"
    }
    
    func addOrbitView(){
        if let orbitBar = Bundle.main.loadNibNamed("OrbitView",
                                                    owner:self , options: nil)?[0] as?  OrbitView{
            orbitBarView = orbitBar
            orbitBarView?.delegate = self
            self.view.addSubview(orbitBarView!)
        }
    }
    
    func addUndoDeleteView(){
        if let undoDeleteBar = Bundle.main.loadNibNamed("UndoDeleteView",
                                                   owner:self , options: nil)?[0] as?  UndoDeleteView{
            undoDeleteBarView = undoDeleteBar
            undoDeleteBarView?.delegate = self
            self.view.addSubview(undoDeleteBarView!)
        }
    }
    
    
    func setCoordinateCurrentLocation(mapView : MGLMapView ,location : CLLocationCoordinate2D){
        // Specify coordinates for our annotations.
        let coordinates = [location]
        
        // Fill an array with point annotations and add it to the map.
        var pointAnnotations = [MGLPointAnnotation]()
        for coordinate in coordinates {
            let point = MGLPointAnnotation()
            point.coordinate = coordinate
            point.title = "To drag this annotation, first tap and hold."
            pointAnnotations.append(point)
        }
        mapView.addAnnotations(pointAnnotations)
    }
    
    func polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D, withMeterRadius: Double) {
        let degreesBetweenPoints = 8.0
        //45 sides
        let numberOfPoints = floor(360.0 / degreesBetweenPoints)
        let distRadians: Double = withMeterRadius / 6371000.0
        
        // earth radius in meters
        let centerLatRadians: Double = coordinate.latitude * M_PI / 180
        let centerLonRadians: Double = coordinate.longitude * M_PI / 180
        var coordinates = [CLLocationCoordinate2D]()
        
        //array to hold all the points
        for index in 0 ..< Int(numberOfPoints) {
            let degrees: Double = Double(index) * Double(degreesBetweenPoints)
            let degreeRadians: Double = degrees * M_PI / 180
            let pointLatRadians: Double = asin(sin(centerLatRadians) * cos(distRadians) + cos(centerLatRadians) * sin(distRadians) * cos(degreeRadians))
            let pointLonRadians: Double = centerLonRadians + atan2(sin(degreeRadians) * sin(distRadians) * cos(centerLatRadians), cos(distRadians) - sin(centerLatRadians) * sin(pointLatRadians))
            let pointLat: Double = pointLatRadians * 180 / M_PI
            let pointLon: Double = pointLonRadians * 180 / M_PI
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(pointLat, pointLon)
            coordinates.append(point)
        }
        let polyline = MGLPolyline(coordinates: UnsafeMutablePointer(mutating: coordinates), count: UInt(coordinates.count))
//        let polygon = MGLPolygon(coordinates: &coordinates, count: UInt(coordinates.count))
        mgMapView?.addAnnotation(polyline)
    }
}

extension OrbitExtendedClass: OrbitViewProtocol{
    
    func orbitAction(){
        topBarView?.descriptionText.text = "Orbit Extended called"
        if let userLoc = userCurrentLocation?.coordinate, let map = mgMapView {
            setCoordinateCurrentLocation(mapView: map,location: userLoc)
            print(userLoc)

            self.orbitBarView?.removeFromSuperview()
            addUndoDeleteView()
            
            polygonCircleForCoordinate(coordinate: userLoc, withMeterRadius: 50.0)
        }
    }
}

extension OrbitExtendedClass: UndoDeleteViewProtocol{
    
    func undoAction() {
    }
    
    func deleteAction() {
    }
}

extension OrbitExtendedClass: MGLMapViewDelegate{
    
    // MARK: - MGLMapViewDelegate methods
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // For better performance, always try to reuse existing annotations. To use multiple different annotation views, change the reuse identifier for each.
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "draggablePoint") {
            return annotationView
        } else {
            return DraggableAnnotationView(reuseIdentifier: "draggablePoint", size: 30)
        }
    }
    
    func setDragState(_ dragState: MGLAnnotationViewDragState, animated: Bool) {
        print("hello")
        
    }
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    /**
     MapView delegate method responsible for color of polygon.
     When altitude is less than the desired altitude then we give the polygon white color else keep the polygon clear.
     */
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor.white
    }
    
    /**
     MapView delegate method responsible for alpha of polygon.
     When altitude is less than the desired altitude then we give the polygon 0.5 alpha  else keep the polygon's alpha as 1.
     */
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 1.0
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor.red
    }
}

