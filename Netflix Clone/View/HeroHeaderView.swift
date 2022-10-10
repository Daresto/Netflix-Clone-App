//
//  HeroHeaderView.swift
//  Netflix Clone
//
//  Created by  Abdurahmon on 19/09/22.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.setTitle("Download", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heroHeaderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func gradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroHeaderImage)
        gradient()
        setupButtonLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func congfigure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        heroHeaderImage.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroHeaderImage.frame = bounds
    }
    
    private func setupButtonLayout() {
        let stackViewForButtons = UIStackView(arrangedSubviews: [playButton, downloadButton])
        stackViewForButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewForButtons.distribution = .fillEqually
        stackViewForButtons.spacing = 35
        addSubview(stackViewForButtons)
        
        NSLayoutConstraint.activate([
            stackViewForButtons.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewForButtons.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            stackViewForButtons.widthAnchor.constraint(equalToConstant: 275),
            stackViewForButtons.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
