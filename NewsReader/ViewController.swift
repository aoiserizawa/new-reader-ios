//
//  ViewController.swift
//  NewsReader
//
//  Created by Alvin Joseph Valdez on 06/12/2016.
//  Copyright © 2016 Alvin Joseph Valdez. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableViewArticles: UITableView!
    var articles: [Article]? = []
    var urlString = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=4bdf758eac5f4bba9fd63190fb286ee2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchArticles()
    }
    
    func fetchArticles(){
        Alamofire.request(urlString).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    
    func parseData(JSONData: Data){
        self.articles = [Article]()
        
        do {
            let json = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [String: AnyObject]
            if let articlesFromJson = json["articles"] as? [[String: AnyObject]]{
                
                for articleFromJson in articlesFromJson{
                    let article = Article()
                    
                    if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String{
                        
                        article.author = author
                        article.desc = desc
                        article.headline = title
                        article.url = url
                        article.imgUrl = urlToImage
                    }
                    self.articles?.append(article)
                }
                
            }
            DispatchQueue.main.async {
                self.tableViewArticles.reloadData()
            }
            
        }
        catch let error{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        cell.title_lbl.text = self.articles?[indexPath.item].headline
        cell.desc_lbl.text = self.articles?[indexPath.item].desc
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imgUrl)!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewController
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }

}

extension UIImageView{
    
    func downloadImage(from url:String){
        let urlRequest = URLRequest(url:URL(string:url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        
        task.resume()
    }
    
}
