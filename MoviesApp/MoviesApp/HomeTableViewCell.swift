//
//  HomeTableViewCell.swift
//  MoviesApp
//
//  Created by Mireya Orta on 3/25/17.
//  Copyright © 2017 Mireya Orta. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Initializers  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
