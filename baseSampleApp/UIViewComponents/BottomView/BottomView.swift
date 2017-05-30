//
//  BottomView.swift
//  baseSampleApp

import UIKit

protocol BottomViewProtocol: NSObjectProtocol {
    func dropAction()
}

class BottomView: UIView {
    
    weak var delegate                            : BottomViewProtocol!
    
    override func awakeFromNib() {
        self.initialize()
    }
    
    // Function to initialize
    func initialize() {
        /* Can pass frame/center as per requirement from the parent view
         func initialize(frame:frameToSet)
         */
 
        self.center = CGPoint(x: SCREEN_WIDTH/2 , y: SCREEN_HEIGHT - 40)
        print(self.frame)
    }
    
    @IBAction func drop(_ sender: Any) {
        print("drop Action")
        self.delegate.dropAction()
    }
}
