//
//  ReviewTableViewCell.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 18/03/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLable: UILabel!
    
    static let identifier = "ReviewTableViewCell"
    
    static func nib() ->UINib{
        return UINib(nibName: "ReviewTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
