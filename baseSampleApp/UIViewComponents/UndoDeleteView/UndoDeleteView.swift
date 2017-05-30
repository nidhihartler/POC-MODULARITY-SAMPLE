//
//  UndoDeleteView.swift
//  baseSampleApp
//
//  Created by Nidhi Gupta on 29/05/17.
//  Copyright © 2017 Nidhi Gupta. All rights reserved.
//

import Foundation
import UIKit

protocol UndoDeleteViewProtocol: NSObjectProtocol {
    func undoAction()
    func deleteAction()
}

class UndoDeleteView: UIView {
    
    weak var delegate                            : UndoDeleteViewProtocol!
    
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
    
    @IBAction func undo(_ sender: Any) {
        print("undo Action")
        self.delegate.undoAction()
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        print("undo Action")
        self.delegate.deleteAction()
    }
}
