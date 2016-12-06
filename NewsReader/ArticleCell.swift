//
//  ArticleCell.swift
//  NewsReader
//
//  Created by Alvin Joseph Valdez on 06/12/2016.
//  Copyright © 2016 Alvin Joseph Valdez. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var desc_lbl: UILabel!
    @IBOutlet weak var author_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
