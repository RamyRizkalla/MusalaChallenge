// Copyright © 2022 Musala. All rights reserved.

import UIKit

struct WeatherOverviewCellData: ViewData {
    var city: String?
    var description: String?
    var temperature: String?
    var maxTemperature: String?
    var minTemperature: String?
}

class WeatherOverviewTableViewCell: UITableViewCell {
    enum Constants {
        static let emptyPlaceHolder: String = "--"
    }

    @IBOutlet private var alllabels: [UILabel]! {
        didSet {
            self.alllabels.forEach { $0.textColor = .white }
        }
    }
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var maxTemperatureLabel: UILabel!
    @IBOutlet private var minTemperatureLabel: UILabel!
    @IBOutlet private var weatherImageView: UIImageView! {
        didSet {
            weatherImageView.isHidden = true
        }
    }

    var model: WeatherOverviewCellData! {
        didSet {
            setData()
        }
    }

    private func setData() {
        locationLabel.text = model.city ?? Constants.emptyPlaceHolder
        descriptionLabel.text = model.description ?? Constants.emptyPlaceHolder
        temperatureLabel.text = model.temperature ?? Constants.emptyPlaceHolder
        maxTemperatureLabel.text = model.maxTemperature ?? Constants.emptyPlaceHolder
        minTemperatureLabel.text = model.minTemperature ?? Constants.emptyPlaceHolder
    }
}


