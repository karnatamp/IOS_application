//
//  wikiDetailsVC.swift
//  WikiSoccer
//
//  Created by Guest User on 13/05/2022.
//

import UIKit

class LeagueDetailsVC: UIViewController {

    var leagueDetails: League?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearOfCreationLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = leagueDetails?.strLeague
        self.yearOfCreationLabel.text = leagueDetails?.intFormedYear
        self.countryLabel.text = leagueDetails?.strCountry
        self.descriptionLabel.text = leagueDetails?.strDescriptionEN
        
        DispatchQueue.main.async { [self] in
            
            if self.leagueDetails != nil {
                self.imageView.image = self.getLeagueImage(leagueView: leagueDetails!)
            }
        }
    }
    
    func getLeagueImage(leagueView: League) -> UIImage {
          
        let data = try? Data.init(contentsOf: URL(string: leagueView.strBadge!)!)
          guard let data = data else { return UIImage() }
          return UIImage(data: data)!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
