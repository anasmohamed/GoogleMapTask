//
//  LocationCellTableViewCell.swift
//  GoogleMapTask
//
//  Created by jets on 12/5/1440 AH.
//  Copyright © 1440 AH Anas. All rights reserved.
//

import UIKit

class LocationCellTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLocationCellLocation: UILabel!
    @IBOutlet weak var labelLocationCellToken: UILabel!
    @IBOutlet weak var labelLocationCellPassword: UILabel!
    @IBOutlet weak var labelLoctionCellUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
