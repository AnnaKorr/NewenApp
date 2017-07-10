//
//  NewsTableViewController.swift
//  Newen
//
//  Created by apple on 08.07.17.
//  Copyright © 2017 Korona. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class NewsTableViewController: UITableViewController {
    @IBOutlet var tblJSON: UITableView!
    
    var newsArray = [[String: AnyObject?]]()
    let realm = try! Realm()
    let newsURL = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=latest&apiKey=6b7c247d75914da0b7a53c8bb951c279"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(newsURL).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJSONVar = JSON(responseData.result.value!)
                
                if let newsData = swiftyJSONVar["articles"].arrayObject {
                    self.newsArray = newsData as! [[String:AnyObject]]
                }
                
                if self.newsArray.count > 0 {
                    self.tblJSON.reloadData()
                }
            
                print(Realm.Configuration.defaultConfiguration.fileURL ?? (AnyObject).self)
        
        
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.newsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        var dict = self.newsArray[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = dict["title"] as? String
        cell.detailTextLabel?.text = dict["publishedAt"] as? String
        cell.imageView?.image = dict["urlToImage"] as? UIImage
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

        }
}
}
