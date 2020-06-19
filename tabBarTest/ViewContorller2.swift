//
//  ViewContorller2.swift
//  tabBarTest
//
//  Created by 김민영 on 2020/06/19.
//  Copyright © 2020 KIMMINYOUNG. All rights reserved.
//

import Foundation
import UIKit

class ViewController2:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewController2 viewDidLoad() call")
    }
    
    @IBAction func backBtn(_ sender: Any) {
        _ = self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtn2(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
