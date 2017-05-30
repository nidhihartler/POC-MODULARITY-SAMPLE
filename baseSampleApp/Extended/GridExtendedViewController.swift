//
//  GridExtendedViewController.swift
//  baseSampleApp
//
//  Created by Nidhi Gupta on 28/05/17.
//  Copyright © 2017 Nidhi Gupta. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

class GridExtendedViewController: BaseViewController{
    var gridBarView       : GridView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showGridView()
        /*
         Uncomment the below line to handle mapview delegate here
         self.mgMapView?.delegate = self
         */
    }
    
    override func onBottomButtonAction() {
        super.onBottomButtonAction()
        
        let dispatchTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            // your function here
            super.topBarView?.descriptionText.text = "Bottom Extended Action called"
        }
    }
    
    override func onRightButtonAction() {
        self.bottomBarView?.removeFromSuperview()
        topBarView?.descriptionText.text = "Right Extended Action called"
    }
    
    func showGridView(){
        if let gridBar = Bundle.main.loadNibNamed("GridView",
                                                   owner:self , options: nil)?[0] as?  GridView{
            gridBarView = gridBar
            gridBarView?.delegate = self
            self.view.addSubview(gridBarView!)
        }
    }
}

extension GridExtendedViewController: GridViewProtocol{
    
    func gridAction(){
        topBarView?.descriptionText.text = "Grid Action called"
        if (!((self.bottomBarView?.superview) != nil)){
            self.addBottomView()
        }
    }
}

extension GridExtendedViewController: MGLMapViewDelegate{
    
    // MARK: - MGLMapViewDelegate methods for Grid
    
    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MGLAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    
    
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
        return UIColor.yellow
    }
}

