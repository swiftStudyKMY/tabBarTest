//
//  thirdVC.swift
//  tabBarTest
//
//  Created by 김민영 on 2020/06/18.
//  Copyright © 2020 KIMMINYOUNG. All rights reserved.
//

import Foundation
import UIKit

class thirdVC:UIViewController
{
    @IBOutlet weak var sb: UISearchBar!
    @IBOutlet weak var tv: UITableView!
    
    var startPoint = 0
    
//    var list : [String] = ["abc","abc","abc","abc","abc","abc"]
    
    var list = [NSDictionary]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.callRequestApi()
        
        sb.delegate = self
        tv.delegate = self
        tv.dataSource = self
    }
    
    func callRequestApi()
    {
        let reqUrl = "http://swiftapi.rubypaper.co.kr:2029/theater/list"
        let sList = 100
        let type = "json"
        
        let urlObj = URL(string: "\(reqUrl)?s_papg=\(self.startPoint)&s_list=\(sList)&type=\(type)")
        
        do{
            let stringData = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)// euc-kr
            
            let encData = stringData.data(using:String.Encoding.utf8.rawValue)
            
            do{
                let apiArray = try JSONSerialization.jsonObject(with: encData!, options: []) as? NSArray
                
                for obj in apiArray! {
                    self.list.append(obj as! NSDictionary)
                }
                
            } catch {
                self.alert("실패! 데이터분석")
            }
            
            self.startPoint += sList
        } catch {
            self.alert("실패! 불러오기")
        }
    }
    
    //
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

extension thirdVC:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        list.append(String(searchBar.text!))
        tv.reloadData()
    }
}

extension thirdVC:UITableViewDelegate
{
    
}

extension thirdVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdVCCell", for: indexPath) as! thirdVCCell
        
//        cell.testLabel.text = list[indexPath.row]
        
        let data = self.list[indexPath.row]
        
        cell.name?.text = data["상영관명"] as? String
        cell.tel?.text = data["연락처"] as? String
        cell.addr?.text = data["소재지도로명주소"] as? String

        return cell
        
    }
    
    
}
