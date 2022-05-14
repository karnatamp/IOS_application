//
//  WikiTVC.swift
//  WikiSoccer
//
//  Created by Guest User on 13/05/2022.
//

import UIKit

class LeagueTVC: UITableViewController {

    var leagues = [League] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getLeagues()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wikiCell", for: indexPath)
        cell.textLabel?.text = self.leagues[indexPath.row].strLeague
        
        cell.imageView?.image = self.getLeagueImage(leagueView: self.leagues[indexPath.row])
        
        return cell
    }

    func download(at url: String, handler: @escaping (Data?) -> Void) {
                
                // 1 - Create URL
                guard let url = URL(string: url) else {
                    debugPrint("Failed to create URL")
                    handler(nil)
                    return
                }
                
                // 2 - Create GET Request
                var request: URLRequest = URLRequest(url: url)
                request.httpMethod = "GET"
             
                // 3 - Create download task, handler will be called when request ended
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    handler(data)
                    }
                task.resume()
            }

    func getLeagues() {
             // 1 - Download games
             download(at:"https://api.npoint.io/25803de7bfb281878f85")
             { (gameData) in
                 if let gameData = gameData {
             
                 // 2 - Decode JSON into a array of Game object
                 let decoder: JSONDecoder = JSONDecoder()
                     do {
                         self.leagues = try decoder.decode([League].self, from: gameData)
                         
                         DispatchQueue.main.async {
                             self.tableView.reloadData()
                         }
                         
                     } catch {
                         debugPrint("Failed to parse data")
                     }
                 }
                 else {
                     debugPrint("Failed to get games data")
                 }
         }
     }
    
    func getLeagueImage(leagueView: League) -> UIImage {
          
        let data = try? Data.init(contentsOf: URL(string: leagueView.strBadge!)!)
          guard let data = data else { return UIImage() }
          return UIImage(data: data)!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segue"{
                let index = tableView.indexPathForSelectedRow
                let seguePageVC = segue.destination as! LeagueDetailsVC
                seguePageVC.leagueDetails = leagues[index!.row]
            }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
