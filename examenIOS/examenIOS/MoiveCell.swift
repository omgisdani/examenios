//
//  MoiveCell.swift
//  examenIOS
//
//  Created by pekxel ara on 22/03/21.
//

import UIKit

class MoiveCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var peliImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
