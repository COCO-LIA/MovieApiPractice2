//
//  ViewController.swift
//  MovieApiPractice2
//
//  Created by 황현지 on 2021/01/05.
//

import UIKit
import ProgressHUD
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var results = [Result]()
    
    //2
    var originalAddress = "https://api.themoviedb.org/3/movie/upcoming?api_key=b804ea7f3826d58a902a69a0e017708f&language=en-US&page=1"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1-1
        getData()
    }


    //1
    func getData() {
        //3
        let resultUrl = URL(string: originalAddress)
        let request = URLRequest(url: resultUrl!)
        
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.show()

        AF.request(request).responseData { (data) in
            if data.error != nil {
                ProgressHUD.dismiss()
                return print("err", data.error?.localizedDescription)
            } else {
                self.results = self.parseJsonData(orgdata:data.data!)
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    ProgressHUD.dismiss()
                }
            }
        }
//
//        AF.request(request).responseJSON { (response) in
//            print(response)
//        }
//
        
        //4 네트워킹
//        URLSession.shared.dataTask(with: request) { (data, response, err) in
//            print("res", response)
//            if err != nil {
//                ProgressHUD.dismiss()
//                return print("err", err?.localizedDescription)
//            } else {
//                self.results = self.parseJsonData(orgdata: data!)
                
//            }
//        }.resume()
    }
    
    //5 데이터 파싱
    func parseJsonData(orgdata: Data) -> [Result] {
        
        self.results = [Result]()
        
//        let decoder = JSONDecoder()
//
//        do {
//            let resultDataStore = try decoder.decode(ResultDataStore.self, from: orgdata)
//            results = resultDataStore.results
//        } catch {
//            print(error)
//        }
//
//        return results
//
        //6 do catch문 json파싱
        do {
            
            let json = JSON(orgdata)
           
            let jsonResults = json["results"].array
            print(results)
            for jsonResult in jsonResults! {
                var result = Result()
                
                
                result.adult = jsonResult["adult"].bool!
                result.orglanguage = jsonResult["original_language"].string!
                result.orgtitle = jsonResult["original_title"].string!
                
                results.append(result)
            }
            
//            let jsonResult = try JSONSerialization.jsonObject(with: orgdata, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
//
//            let jsonResults = jsonResult?["results"] as! [AnyObject]
//            print(jsonResults)
//
//            for jsonResult in jsonResults {
//
//                result.adult = jsonResult["adult"] as! Bool
//                result.orglanguage = jsonResult["original_language"] as! String
//                result.orgtitle = jsonResult["original_title"] as! String
////                result.popularity = jsonResult["popularity"] as! Int
//
//                results.append(result)
//
//            }

        } catch {
            print("-------",error)
        }
        
        return results
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        cell1.textLabel?.text = results[indexPath.row].orgtitle
        cell1.detailTextLabel?.text = results[indexPath.row].orglanguage
        
        return cell1
    }
    
}
