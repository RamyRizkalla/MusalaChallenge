//
//  CityDetailsTableViewCell.swift
//  MusalaWeather
//
//  Created by Ramy Rizkalla on 03/02/2022.
// Copyright © 2022 Musala. All rights reserved.
//

import Foundation
import UIKit

struct CityDetailsTableViewCellData {
    let date: String
    let minTemp: Double
    let maxTemp: Double
}

class CityDetailsTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var weatherStateImageView: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!

    var model: CityDetailsTableViewCellData! {
        didSet {
            setModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        weatherStateImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 7.5
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.blue.cgColor
    }

    private func setModel() {
        dateLabel.text = model.date
        temperatureLabel.text = "\(model.minTemp.formattedStringValue) / \(model.maxTemp.formattedStringValue)"
    }

    func setImage(_ data: Data?) {
        let image: UIImage? = {
            guard let data = data else { return Assets.Images.imageUnavailable }
            return UIImage(data: data)
        }()
        DispatchQueue.main.async {
            self.weatherStateImageView.image = image
        }
    }
}
