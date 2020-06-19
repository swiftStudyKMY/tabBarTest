//
//  ViewController.swift
//  tabBarTest
//
//  Created by 김민영 on 2020/06/18.
//  Copyright © 2020 KIMMINYOUNG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController viewDidLoad() call")
    }
    
    @IBAction func moveBtn1(_ sender: Any) {
        
        guard let uvc = self.storyboard?.instantiateViewController(identifier: "vc2") else {
            return
        }
        
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        self.present(uvc, animated:  true)
        
    }
    
    @IBAction func moveBarBtn1(_ sender: Any) {
        
        guard let uvc = self.storyboard?.instantiateViewController(identifier: "vc2") else {
            return
        }
        
        self.navigationController?.pushViewController(uvc, animated: true)
        
    }
    
    
    
}


