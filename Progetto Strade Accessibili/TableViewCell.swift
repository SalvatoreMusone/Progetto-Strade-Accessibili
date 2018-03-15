//
//  TableViewCell.swift
//  Progetto Strade Accessibili
//
//  Created by Salvatore Musone on 15/03/2018.
//  Copyright © 2018 Salvatore Musone. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var Arrivo: UILabel!
    @IBOutlet var Partenza: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
