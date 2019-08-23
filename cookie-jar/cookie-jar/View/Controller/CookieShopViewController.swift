//
//  CookieShopViewController.swift
//  cookie-jar
//
//  Created by Gabriel Siu on 2019-08-21.
//  Copyright © 2019 Gabriel Siu. All rights reserved.
//

import UIKit

class CookieShopViewController: UIViewController {
    // MARK: Properties
    private let cookieService: CookieService
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Cookie Shop"
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.text = "Points: 5"
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, pointsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private var cookieCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CookieCell.self, forCellWithReuseIdentifier: "CookieCell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: Lifecycle
    init(cookieService: CookieService) {
        self.cookieService = cookieService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [labelStack, cookieCollectionView].forEach { view.addSubview($0) }
        cookieCollectionView.delegate = self
        cookieCollectionView.dataSource = self
        
        labelStack.setEdgeConstraints(top: view.safeAreaLayoutGuide.topAnchor, bottom: cookieCollectionView.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        cookieCollectionView.setEdgeConstraints(top: labelStack.bottomAnchor, bottom: view.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}

extension CookieShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cookieService.getCookies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CookieCell", for: indexPath) as? CookieCell {
            cell.setData(cookie: cookieService.getCookies()[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.width / 3)
    }
}
