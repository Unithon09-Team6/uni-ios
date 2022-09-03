//
//  SearchViewController.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class SearchViewController: UIViewController {
    
    typealias ProjectImage = UNITHONTeam6IOSAsset.Assets
    typealias ProjectPretendardFont = UNITHONTeam6IOSFontFamily.Pretendard
    
    
    private let navigationView = UIView()
    private let backButton = UIButton().then {
        $0.setImage(ProjectImage.iconArrowBack.image, for: .normal)
    }
    private let navigationTitleLabel = UILabel().then {
        $0.text = "검색"
        $0.font = ProjectPretendardFont.semiBold.font(size: 18)
        $0.textColor = .white
    }
    
    private let searchBar = UISearchBar().then {
        $0.backgroundColor = .searchBarBackgroudNavy
        $0.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        $0.placeholder = "원하는 메뉴를 검색해주세요"
        $0.cornerRadius = 25
        $0.searchTextField.font = ProjectPretendardFont.medium.font(size: 14)
        $0.searchTextField.backgroundColor = .clear
        $0.backgroundImage = UIImage()
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: createRecipeLayout())
        collectionView.register(cell: RecipeCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setLayout()
        setCollectionView()
    }
    
    // MARK: - Function
    
    private func setUI() {
        view.backgroundColor = .backgroudNavy
    }
    
    private func setLayout() {
        self.view.addSubviews([navigationView, searchBar, collectionView])
        navigationView.addSubviews([backButton, navigationTitleLabel])
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
    }

}

// MARK: - CollectionView

extension SearchViewController {
    
    private func createRecipeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(155/333),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(224/333))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 23
        section.contentInsets = NSDirectionalEdgeInsets(top: 27, leading: 21, bottom: 27, trailing: 21)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.RecipeCollectionViewCell, for: indexPath) as? RecipeCollectionViewCell else { fatalError() }
        return cell
    }
}
