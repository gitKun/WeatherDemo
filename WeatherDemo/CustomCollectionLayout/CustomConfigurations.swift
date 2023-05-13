//
//  CustomConfigurations.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/11.
//

import Foundation
import UIKit


struct GoodsContentConfiguration: UIContentConfiguration, Hashable {

    var model: GoodsModel? = nil

    func makeContentView() -> UIView & UIContentView {
        return GoodsCellContentView(configuration: self)
    }

    func updated(for state: UIConfigurationState) -> GoodsContentConfiguration {
        return self
        /*
        guard let state = state as? UICellConfigurationState else { return self }
        var updatedConfig = self
        return updatedConfig
        */
    }
}


final class GoodsCellContentView: UIView, UIContentView {

    private var appliedConfiguration: GoodsContentConfiguration!
    private var imageHeightRatio: NSLayoutConstraint!

    init(configuration: GoodsContentConfiguration) {
        super.init(frame: .zero)

        setupInternalViews()
        apply(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? GoodsContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }

    func setupInternalViews() {
        imageView.backgroundColor = .lightGray
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageHeightRatio = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            imageHeightRatio
            
        ])

        nameLable.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nameLable.textColor = .rgba(r: 51, g: 51, b: 51)
        descLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descLabel.textColor = .rgba(r: 183, g: 183, b: 183)
        priceLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        priceLabel.textColor = .systemCyan

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 6.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
        stackView.addArrangedSubview(nameLable)
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(priceLabel)
    }

    func apply(configuration: GoodsContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration

        guard let model = configuration.model else {
            imageHeightRatio = imageHeightRatio.setMultiplier(multiplier: 1.0)
            imageView.backgroundColor = .red
            nameLable.isHidden = true
            descLabel.isHidden = true
            priceLabel.isHidden = true
            return
        }

        imageView.backgroundColor = .lightGray
        nameLable.isHidden = false
        descLabel.isHidden = false
        priceLabel.isHidden = false

        imageHeightRatio = imageHeightRatio.setMultiplier(multiplier: model.imageHWRatio)
        nameLable.text = model.name
        descLabel.text = model.desc
        priceLabel.text = model.price
    }

// MARK: - UI element

    private let imageView = UIImageView()
    private let nameLable = UILabel()
    private let descLabel = UILabel()
    private let priceLabel = UILabel()
}
