//
//  ViewService.swift
//  StackAndGradient3
//
//  Created by Дмитрий Исаев on 24.07.2024.
//

import UIKit

class ViewService {
    
    static let shared = ViewService()
    private init() {}
    
    func getGradient(startColor: UIColor?, endColor: UIColor? = UIColor(hex: "#565C87FF"), frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        
        gradient.colors = [
            startColor?.cgColor ?? UIColor.white.cgColor,
            endColor?.cgColor ?? UIColor.white.cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.locations = [-0.3, 0.3]
        
        return gradient
    }
    
    func createCardView(gradientColor: String, width: CGFloat) -> UIView {
        let card = UIView()
        card.layer.cornerRadius = 25
        card.layer.cornerCurve = .continuous
        card.clipsToBounds = true
        card.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        let gradient = getGradient(startColor: UIColor(hex: gradientColor))
        card.layer.addSublayer(gradient)
        
        return card
    }
    
    func createCardImage(image: UIImage) -> UIImageView {
        let cardImage = UIImageView()
        cardImage.image = image
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardImage.widthAnchor.constraint(equalToConstant: 27).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 27).isActive = true
        return cardImage
    }
    
    func createCardTitle(titleText: String) -> UILabel {
        let label = UILabel()
        label.text = titleText
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
    
    func createRateStack(rate: Float) -> UIStackView {
        let rateStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 5
            stack.alignment = .center
            return stack
        }()
        
        let rateImage = UIImageView()
        rateImage.image = UIImage(systemName: "star.fill")
        rateImage.tintColor = .white
        rateImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        rateImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        let rateLabel = UILabel()
        rateLabel.text = "\(rate)"
        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        rateLabel.textColor = .white
        
        rateStack.addArrangedSubview(rateImage)
        rateStack.addArrangedSubview(rateLabel)
        
        return rateStack
    }
    
    func createViewsLabel(views: Int) -> UILabel {
        let label = UILabel()
        label.text = "\(views) views"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        return label
    }
    
    func createSideStack(items: [UIView]) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 17
        
        items.forEach {
            stack.addArrangedSubview($0)
        }
        
        return stack
    }
}
