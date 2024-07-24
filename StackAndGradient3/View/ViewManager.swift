//
//  ViewManager.swift
//  StackAndGradient3
//
//  Created by Дмитрий Исаев on 24.07.2024.
//

import UIKit

class ViewManager {
    
    private let service = ViewService.shared
    private var headerStack = UIStackView()
    private var cardsStack = UIStackView()
    
    private lazy var width: CGFloat = {
        return (view.frame.width/2) - 33
    }()
    
    var controller: UIViewController
    var view: UIView
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    func createAppheader(headerTitle: String) {
        headerStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let headerTitle = {
            let title = UILabel()
            title.text = headerTitle
            title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            title.textColor = .white
            title.numberOfLines = 0
            return title
        }()
        
        let headerButton = {
            let button = UIButton()
            button.tintColor = .white
            button.widthAnchor.constraint(equalToConstant: 31).isActive = true
            button.heightAnchor.constraint(equalToConstant: 31).isActive = true
            button.layer.cornerRadius = 16
            button.clipsToBounds = true
            
            let gradient = service.getGradient(startColor: UIColor(hex: "#B2A1F7FF"), frame: CGRect(x: 0, y: 0, width: 31, height: 31))
            button.layer.addSublayer(gradient)
            
            let buttonImage = {
                let imageView = UIImageView()
                imageView.image = UIImage(systemName: "magnifyingglass")
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
                return imageView
            }()
            
            button.addSubview(buttonImage)
            
            NSLayoutConstraint.activate([
                buttonImage.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                buttonImage.centerYAnchor.constraint(equalTo: button.centerYAnchor)
            ])
            
            return button
        }()
        
        headerStack.addArrangedSubview(headerTitle)
        headerStack.addArrangedSubview(headerButton)
        
        view.addSubview(headerStack)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
    
    func createCardsStack() {
        let tikTikCard = createLongCard(item: service.createCardView(gradientColor: "#58CFEFFF", width: width), image: .tiktok, title: "TikTok \nabs", rate: 4.9, views: 1234)
        let drawCard = createshortCard(item: service.createCardView(gradientColor: "#5BD6B9FF", width: width), image: .clock, title: "Art & Draw")
        let instagramCard = createshortCard(item: service.createCardView(gradientColor: "#E79DA7FF", width: width), image: .inst, title: "Instagram")
        let youTubeCard = createLongCard(item: service.createCardView(gradientColor: "#B2A1F7FF", width: width), image: .you, title: "YouTube \nabs", rate: 4.9, views: 123)
        
        let leftStack = service.createSideStack(items: [tikTikCard, drawCard])
        let rightStack = service.createSideStack(items: [instagramCard, youTubeCard])
        
        cardsStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(leftStack)
            stack.addArrangedSubview(rightStack)
            return stack
        }()
        
        view.addSubview(cardsStack)
        
        NSLayoutConstraint.activate([
            cardsStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 33),
            cardsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            cardsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
    
    func createLongCard (item: UIView, image: UIImage, title: String, rate: Float, views: Int) -> UIView {
        let cardImage = service.createCardImage(image: image)
        let cardTite = service.createCardTitle(titleText: title)
        let cardRate = service.createRateStack(rate: rate)
        let cardViews = service.createViewsLabel(views: views)
        
        let topStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 12
            stack.alignment = .leading
            stack.addArrangedSubview(cardImage)
            stack.addArrangedSubview(cardTite)
            return stack
        }()
        
        let bottomStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 2
            stack.alignment = .leading
            stack.addArrangedSubview(cardRate)
            stack.addArrangedSubview(cardViews)
            return stack
        }()
        
        let mainStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 21
            stack.alignment = .leading
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(topStack)
            stack.addArrangedSubview(bottomStack)
            return stack
        }()
        
        item.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: item.topAnchor, constant: 25),
            mainStack.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 25),
            mainStack.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -25),
            mainStack.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -27)
        ])
        
        
        return item
    }
    
    func createshortCard (item: UIView, image: UIImage, title: String) -> UIView {
        let cardImage = service.createCardImage(image: image)
        let cardTite = service.createCardTitle(titleText: title)
        
        let nextArrowButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
            button.tintColor = .white
            button.widthAnchor.constraint(equalToConstant: 14).isActive = true
            button.heightAnchor.constraint(equalToConstant: 14).isActive = true
            return button
        }()
        
        
        let hStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.addArrangedSubview(cardImage)
            stack.addArrangedSubview(nextArrowButton)
            return stack
        }()
        
        let vStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 13
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(hStack)
            stack.addArrangedSubview(cardTite)
            return stack
        }()
        
        item.addSubview(vStack)
        
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: item.topAnchor, constant: 25),
            vStack.leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: 25),
            vStack.trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: -25),
            vStack.bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: -30),
        ])
        
        return item
    }
    
    func createServiceCard() {
        let serviceTitle = {
            let title = UILabel()
            title.text = "Лучшие сервисы"
            title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            title.textColor = .white
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()
        
        view.addSubview(serviceTitle)
        
        let serviceCard = {
            let card = UIView()
            card.layer.cornerRadius = 25
            card.layer.cornerCurve = .continuous
            card.translatesAutoresizingMaskIntoConstraints = false
            card.clipsToBounds = true
            
            let gradient = service.getGradient(startColor: UIColor(hex: "#949AC5FF"), frame: CGRect(x: 0, y: 0, width: 400, height: 200))
            card.layer.addSublayer(gradient)
            
            return card
        }()
        
        view.addSubview(serviceCard)
        
        let serviceImage = {
            let imageView = UIImageView()
            imageView.image = .baner
            imageView.widthAnchor.constraint(equalToConstant: 152).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 122).isActive = true
            return imageView
        }()
        
        let serviceCardTitle = service.createCardTitle(titleText: "Design & \nDevelopment")
        let serviceRate = service.createRateStack(rate: 4.9)
        
        let infoImage = {
            let image = UIImageView()
            image.image = .comp
            image.tintColor = .white
            image.widthAnchor.constraint(equalToConstant: 15).isActive = true
            image.heightAnchor.constraint(equalToConstant: 15).isActive = true
            return image
        }()
        
        let infoLabel = {
            let label = UILabel()
            label.text = "Complete Design"
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
            label.textColor = .white
            return label
        }()
        
        let infoStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 5
            stack.alignment = .center
            stack.addArrangedSubview(infoImage)
            stack.addArrangedSubview(infoLabel)
            return stack
        }()
        
        let priceLabel = {
            let label = UILabel()
            label.text = "$1234"
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = UIColor(hex: "#58CFEFFF")
            return label
        }()
        
        let vStack = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 5
            stack.alignment = .leading
            stack.addArrangedSubview(serviceCardTitle)
            stack.addArrangedSubview(serviceRate)
            stack.addArrangedSubview(infoStack)
            stack.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5)))
            stack.addArrangedSubview(priceLabel)
            return stack
        }()
        
        let hStack = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .equalSpacing
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(serviceImage)
            stack.addArrangedSubview(vStack)
            return stack
        }()
        
        view.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            serviceTitle.topAnchor.constraint(equalTo: cardsStack.bottomAnchor, constant: 41),
            serviceTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            serviceTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            serviceCard.topAnchor.constraint(equalTo: serviceTitle.bottomAnchor, constant: 21),
            serviceCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            serviceCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            hStack.topAnchor.constraint(equalTo: serviceCard.topAnchor, constant: 25),
            hStack.leadingAnchor.constraint(equalTo: serviceCard.leadingAnchor, constant: 25),
            hStack.trailingAnchor.constraint(equalTo: serviceCard.trailingAnchor, constant: -25),
            hStack.bottomAnchor.constraint(equalTo: serviceCard.bottomAnchor, constant: -25)
        ])
    }
}
