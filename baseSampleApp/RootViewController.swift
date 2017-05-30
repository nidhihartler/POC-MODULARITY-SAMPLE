//
//  RootViewController.swift
//  baseSampleApp
//
//  Created by Nidhi Gupta on 28/05/17.
//  Copyright © 2017 Nidhi Gupta. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I am Root")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("I am Root")
    }
    
    @IBAction func gridButtonAction(_ sender: Any) {
        print("root grid")
 
        let initialViewController = GridExtendedViewController()
        self.present(initialViewController, animated: true, completion: nil)
    }
    
    @IBAction func orbitButtonAction(_ sender: Any) {
        print("root orbit")
        
        let initialViewController = OrbitExtendedClass()
        self.present(initialViewController, animated: true, completion: nil)
    }
}
