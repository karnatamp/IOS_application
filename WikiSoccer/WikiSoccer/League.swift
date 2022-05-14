//
//  Wiki.swift
//  WikiSoccer
//
//  Created by Guest User on 13/05/2022.
//

import Foundation

class League: Decodable {
    var strLeague: String? = "" // Name
    var strBadge: String? = "" // Image
    var strDescriptionEN: String? = "" // Description
    var intFormedYear: String? = "" // Formed Year
    var strCountry: String? = "" // Country
    
    init (strLeague: String?, strBadge: String?, strDescriptionEN: String?, intFormedYear: String?, strCountry: String?) {
        self.strLeague = strLeague
        self.strBadge = strBadge
        self.strDescriptionEN = strDescriptionEN
        self.intFormedYear = intFormedYear
        self.strCountry = strCountry
    }
}
