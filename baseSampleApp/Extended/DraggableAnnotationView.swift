//
//  DraggableAnnotationView.swift
//  DropPointFunctionality
//
//  Created by Nidhi Gupta on 25/05/17.
//  Copyright © 2017 Nidhi Gupta. All rights reserved.
//

import Mapbox

// MGLAnnotationView subclass
class DraggableAnnotationView: MGLAnnotationView {
    
    init(reuseIdentifier: String, size: CGFloat) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // `isDraggable` is a property of MGLAnnotationView, disabled by default.
        isDraggable = true
        
        // This property prevents the annotation from changing size when the map is tilted.
        scalesWithViewingDistance = false
        
        // Begin setting up the view.
        frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        backgroundColor = .darkGray
        
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = size / 2
        layer.borderWidth = 4
        layer.borderColor = UIColor.orange.cgColor
        layer.shadowColor = UIColor.green.cgColor
        layer.shadowOpacity = 0.1
    }
    
    // These two initializers are forced upon us by Swift.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom handler for changes in the annotation’s drag state.
    
    override func setDragState(_ dragState: MGLAnnotationViewDragState, animated: Bool) {
        super.setDragState(dragState, animated: animated)
        
        switch dragState {
        case .starting:
            print("Starting", terminator: "")
            startDragging()
        case .dragging:
            print(".", terminator: "")
        case .ending, .canceling:
            print("Ending")
            endDragging()
        case .none:
            return
        }
    }
    
    // When the user interacts with an annotation, animate opacity and scale changes.
    func startDragging() {
        let startCoord = self.annotation?.coordinate
        print(startCoord)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.layer.opacity = 0.8
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }, completion: nil)
    }
    
    func endDragging() {
        let endCoord = self.annotation?.coordinate
        print(endCoord)
        transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.layer.opacity = 1
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }, completion: nil)
    }
 }
