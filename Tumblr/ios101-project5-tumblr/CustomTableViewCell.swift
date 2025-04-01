//
//  CustomTableViewCell.swift
//  ios101-project5-tumblr
//
//  Created by vincent Jared on 4/2/25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var DataLabel: UILabel!
    
    @IBOutlet weak var UIimageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
