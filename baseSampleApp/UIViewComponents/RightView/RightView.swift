//
//  RightView.swift
//  baseSampleApp

import Foundation
import UIKit

protocol FirstviewProtocol: NSObjectProtocol {
    func goAction()
}

class RightView: UIView {
    
    weak var delegate                            : FirstviewProtocol!

    override func awakeFromNib() {
        self.initialize()
    }
    
    
    // Function to initialize
    func initialize() {
        print(self.frame)
        self.center = CGPoint(x: SCREEN_WIDTH-self.frame.width-15 , y: SCREEN_HEIGHT/2)
    }
    
    @IBAction func go(_ sender: Any) {
        print("go Action")
        self.delegate.goAction()
    }    
}
