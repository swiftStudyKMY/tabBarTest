//
//  secondVC.swift
//  tabBarTest
//
//  Created by 김민영 on 2020/06/18.
//  Copyright © 2020 KIMMINYOUNG. All rights reserved.
//

import Foundation
import UIKit

import WebKit

class secondVC : UIViewController{
    
    @IBOutlet weak var sb: UISearchBar!
    @IBOutlet weak var wv: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sb.delegate = self
        wv.navigationDelegate = self
        
        wv.allowsBackForwardNavigationGestures = true
        
        requestURL(urlString: "https://m.youtube.com./")
    }
    
    
    
    func requestURL(urlString : String){
        
        self.wv.load(URLRequest(url: URL(string:urlString)!))
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        if wv.canGoBack{
            wv.goBack()
            wv.reload()
        }else{
            alert("뒤로 갈수 없습니다.")
        }
    }
    
    @IBAction func forwardBtn(_ sender: Any) {
        if wv.canGoForward{
            wv.goForward()
            wv.reload()
        }else{
            alert("앞으로 갈수 없습니다.")
        }
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        self.requestURL(urlString: "https://m.youtube.com./")
    }
    @IBAction func shareBtn(_ sender: Any) {
        
        let shareTxt = sb.placeholder
        
        let txtToShare = [shareTxt]
        
        let vc = UIActivityViewController(activityItems: txtToShare as [Any], applicationActivities: nil)
        
//        vc.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.mail ]
        vc.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func alert(_ msg: String, onClick: (()-> Void)? = nil){
        let controller = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            onClick?()
        }))
        DispatchQueue.main.async {
            self.present(controller,animated: false)
        }
    }
    
}

extension secondVC : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text!.count > 0 {
            requestURL(urlString: searchBar.text!)
        }else{
            self.alert("유효하지 않은 url입니다.")
        }
        
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension secondVC : WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
        sb.placeholder = webView.url?.absoluteString
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        self.alert(error.localizedDescription)
    }
}
