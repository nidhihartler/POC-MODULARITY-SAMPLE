//
//  BaseViewController.swift
//  baseSampleApp
//
//  Created by Nidhi Gupta on 27/05/17.
//  Copyright © 2017 Nidhi Gupta. All rights reserved.
//

import UIKit
import Mapbox

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class BaseViewController: UIViewController, CLLocationManagerDelegate {

    var rightBarView       : RightView?
    var bottomBarView       : BottomView?
    var topBarView       : ShowView?

    var locationManager = CLLocationManager();
    var userCurrentLocation : CLLocation?

    let ZOOM_DISATNCE_FOR_MAP : CLLocationDistance = 1200
    let PITCH_FOR_MAP : CGFloat = 0
    let HEADING_FOR_MAP :CLLocationDirection = 0

    var mgMapView: MGLMapView?

    override func viewDidLoad() {
        locationSetUp()
        mapSetUp()
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addRightView()
        addBottomView()
        addTopView()
    }
    
    func locationSetUp(){
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func mapSetUp(){
        mgMapView = MGLMapView(frame: view.bounds)
        mgMapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mgMapView?.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mgMapView?.showsUserLocation = true
        mgMapView?.isRotateEnabled = false
        mgMapView?.tintColor = UIColor.darkGray
        mgMapView?.isOpaque = false
//        mgMapView?.delegate = self
        self.view.addSubview(mgMapView!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userCurrentLocation = locations.last
        locationManager.stopUpdatingLocation()
        if (userCurrentLocation != nil){
            if let mapV = mgMapView{
                setMapToLocation(mapView: mapV,location: (userCurrentLocation?.coordinate)!)
            }else{print("map found nil")}
        }
    }

    func setMapToLocation(mapView : MGLMapView ,location : CLLocationCoordinate2D){
        print("Setting map to location" + String(location.latitude) + String(location.longitude))
        let camera = MGLMapCamera(lookingAtCenter: location, fromDistance:ZOOM_DISATNCE_FOR_MAP, pitch: PITCH_FOR_MAP, heading: HEADING_FOR_MAP)
        mapView.camera = camera
        mapView.showsUserLocation = true
    }

    func addTopView(){
        if let topView = Bundle.main.loadNibNamed("ShowView",
                                                    owner:self , options: nil)?[0] as?  ShowView{
            topBarView = topView
            self.view.addSubview(topBarView!)
        }
    }

    func addRightView(){
        if let rightView = Bundle.main.loadNibNamed("RightView",
                                                                        owner:self , options: nil)?[0] as?  RightView{
            rightBarView = rightView
            rightBarView?.delegate = self
            self.view.addSubview(rightBarView!)
        }
    }
    
    func addBottomView(){
        if let bottomBar = Bundle.main.loadNibNamed("BottomView",
                                                    owner:self , options: nil)?[0] as?  BottomView{
            bottomBarView = bottomBar
            bottomBarView?.delegate = self
            self.view.addSubview(bottomBarView!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onRightButtonAction() {
        topBarView?.descriptionText.text = "Right Super method called"
        
    }
    
    func onBottomButtonAction() {
        topBarView?.descriptionText.text = "Bottom super method called"
    }
}


extension BaseViewController: FirstviewProtocol{
    
    func goAction(){
        onRightButtonAction()
    }
}

extension BaseViewController: BottomViewProtocol{
        
    func dropAction(){
        onBottomButtonAction()
    }
}
