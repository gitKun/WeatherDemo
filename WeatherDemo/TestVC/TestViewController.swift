//
//  TestViewController.swift
//  WeatherDemo
//
//  Created by liyakun on 2023/5/16.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()

        if let filePath = Bundle.main.path(forResource: "hot_fd_list", ofType: "json")
        {
            let fileUrl = URL(fileURLWithPath: filePath)
            do {
                let jsonData = try Data.init(contentsOf: fileUrl)
                let decoder = JSONDecoder()
                let model = try decoder.decode(XTHotReport.self, from: jsonData)
                dump(model)
            } catch let error {
                print(error)
            }
        }
    }
    

    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        var index = sender.selectedSegmentIndex

        UIView.animate(withDuration: 5) {
            if index == 0 {
                self.firstView.isHidden = false
                self.secondView.isHidden = true
            } else {
                self.firstView.isHidden = true
                self.secondView.isHidden = false
            }
        }
    }

    @objc func moreInfoButtonClicked(_ sender: UIButton) {
        print("more Info Button Clicked!")
    }
    
    
    private func configureHierarchy() {
        view.backgroundColor = .systemGroupedBackground

        var config = UIButton.Configuration.plain()
        var attributedTitle = AttributedString("了解更多")
        attributedTitle.font = .systemFont(ofSize: 14, weight: .medium)
        attributedTitle.foregroundColor = .white
        config.attributedTitle = attributedTitle
        config.attributedTitle = attributedTitle
        var imgConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
        imgConfig = imgConfig.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14.0)))
        config.image = UIImage.init(systemName: "chevron.right", withConfiguration: imgConfig)
        config.contentInsets = .zero
        config.imagePadding = 4
        config.titleAlignment = .leading
        config.imagePlacement = .trailing
		
        let moreInfoButton = UIButton(configuration: config)
        moreInfoButton.configurationUpdateHandler = { button in
            button.alpha = button.isHighlighted ? 0.5 : 1
        }
        moreInfoButton.addTarget(self, action: #selector(self.moreInfoButtonClicked(_:)), for: .touchUpInside)
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moreInfoButton)
        NSLayoutConstraint.activate([
            moreInfoButton.heightAnchor.constraint(equalToConstant: 22),
            moreInfoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            moreInfoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

//        var config = UIButton.Configuration.borderedProminent()
//        config.baseForegroundColor = UIColor.systemRed
//        config.baseBackgroundColor = .clear
//        config.background.strokeColor = .systemRed
//        config.title = "预约试驾"
//        config.titleAlignment = .center
//
//        let action = UIAction { act in
//            print("立即购买被点击！")
//        }
//        let testDivButton = UIButton(configuration: config, primaryAction: action)
//
//        config = .filled()
//        config.background.cornerRadius = 4
//        config.cornerStyle = .fixed
//        config.baseBackgroundColor = .systemRed
//        config.baseForegroundColor = .white
//        config.title = "立即购买"
//        let buyNowButton =  UIButton(configuration: config)
//
//        view.addSubview(testDivButton)
//        view.addSubview(buyNowButton)
//        testDivButton.translatesAutoresizingMaskIntoConstraints = false
//        buyNowButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            testDivButton.heightAnchor.constraint(equalToConstant: 40),
//            testDivButton.widthAnchor.constraint(equalToConstant: 106),
//            testDivButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//            testDivButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
//            buyNowButton.heightAnchor.constraint(equalToConstant: 40),
//            buyNowButton.widthAnchor.constraint(equalToConstant: 106),
//            buyNowButton.trailingAnchor.constraint(equalTo: testDivButton.leadingAnchor, constant: -12),
//            buyNowButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300)
//        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
