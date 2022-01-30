//
//  AppleStyleCollectionViewHeader.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 31.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import UIKit

class ASCollectionViewHeader: UICollectionReusableView {
    
    private lazy var largeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        button.setTitle("mk", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didClickedOnButton(_:)), for: .touchUpInside)
        return button
    }()
    
    static var reuseIdentifier: String {
        get { return "appleStyleHeader"}
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       setConstraints()
     }
     
     //initWithCode to init view from xib or storyboard
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     }
    
    func setConstraints() {
        setConstraintToLargeTitleLabel()
        setConstraintsToButton()
    }
    
    func setConstraintToLargeTitleLabel() {
        addSubview(largeTitleLabel)
        NSLayoutConstraint.activate([
            largeTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            largeTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            largeTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setConstraintsToButton() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leftAnchor.constraint(equalTo: largeTitleLabel.rightAnchor, constant: 5),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
    func setHeader(title: String, buttonImage: UIImage?) {
        setConstraints()
        largeTitleLabel.text = title
        guard let buttonImage = buttonImage else { return }
        button.setImage(buttonImage, for: .normal)
    }
    
    
    @objc func didClickedOnButton(_ sender: UIButton) {
        print("button has been clicked")
    }
    
    
    
        
}
