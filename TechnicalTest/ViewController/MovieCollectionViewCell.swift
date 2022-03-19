//
//  MovieCollectionViewCell.swift
//  TechnicalTest
//
//  Created by Dion Lamilga on 18/03/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    
    static func nib() ->UINib{
        return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
