//
//  BottomView.swift
//  baseSampleApp

import UIKit

class ShowView: UIView {
    
    @IBOutlet weak var descriptionText: UILabel!
    override func awakeFromNib() {
        self.initialize()
    }
    
    // Function to initialize
    func initialize() {
        /* Can pass frame as per requirement from the parent view
         func initialize(frame:frameToSet)
         */
        self.center = CGPoint(x: SCREEN_WIDTH/2 , y: 30)
        print(self.frame)
    }
}
