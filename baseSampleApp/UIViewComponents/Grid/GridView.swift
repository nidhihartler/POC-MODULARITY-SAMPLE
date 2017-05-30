//
//  BottomView.swift
//  baseSampleApp

import UIKit

protocol GridViewProtocol: NSObjectProtocol {
    func gridAction()
}

class GridView: UIView {
    weak var delegate                            : GridViewProtocol!
    
    override func awakeFromNib() {
        self.initialize()
    }
    
    // Function to initialize
    func initialize() {
        /* Can pass frame/center as per requirement from the parent view
         func initialize(frame:frameToSet)
         */
                
        self.center = CGPoint(x: SCREEN_WIDTH/2 , y: SCREEN_HEIGHT/2)
        print(self.frame)
    }
    
    @IBAction func grid(_ sender: Any) {
        self.delegate.gridAction()
    }
}
