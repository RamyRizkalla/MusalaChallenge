// Copyright © 2022 Musala. All rights reserved.

import UIKit

class CitiesListTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!

    var model: String! {
        didSet {
            titleLabel.text = model
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 7.5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.blue.cgColor
    }
}
