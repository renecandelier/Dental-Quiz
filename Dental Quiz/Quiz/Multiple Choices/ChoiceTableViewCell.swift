//
//  ChoiceTableViewCell.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/25/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
//

import UIKit

class ChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var choiceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func prepareForReuse() {
        // TODO: Clean what is not needed
        selectedBackgroundView = nil
        isSelected = false
        setSelected(false, animated: false)
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
