// Copyright © 2022 Musala. All rights reserved.

import UIKit

struct WeatherDetailsCellData: ViewData {
    var leftHeader: String
    var leftInfo: String?
    var rightHeader: String
    var rightInfo: String?
}

class WeatherDetailsTableViewCell: UITableViewCell {
    enum Constants {
        static let emptyPlaceHolder: String = "--"
    }
    
    @IBOutlet private var alllabels: [UILabel]! {
        didSet {
            self.alllabels.forEach { $0.textColor = .white }
        }
    }
    @IBOutlet private var leftHeaderLabel: UILabel!
    @IBOutlet private var leftInfoLabel: UILabel!
    @IBOutlet private var rightHeaderLabel: UILabel!
    @IBOutlet private var rightInfoLabel: UILabel!
    
    func setData(_ data: WeatherDetailsCellData) {
        leftHeaderLabel.text = data.leftHeader
        leftInfoLabel.text = data.leftInfo ?? Constants.emptyPlaceHolder
        rightHeaderLabel.text = data.rightHeader
        rightInfoLabel.text = data.rightInfo ?? Constants.emptyPlaceHolder
    }
}
