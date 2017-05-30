//
//  firstview.swift
//  baseSampleApp

import Foundation
import UIKit

protocol OrbitViewProtocol: NSObjectProtocol {
    func orbitAction()
}

class OrbitView: UIView {
    
    weak var delegate                            : OrbitViewProtocol!
    
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
    
    @IBAction func orGo(_ sender: Any) {
        print("orbit Action")
        self.delegate.orbitAction()
    }
}
