//
//  MainVC.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then

final class MainVC: UIViewController {
    
    let mainCategories = [MainCategory(description: "한국인이라면 역시", name: "한식", image: UIImage(), color: .categoryPurpleLight),
                          MainCategory(description: "집에서 쉽게 해먹자!", name: "중식", image: UIImage(), color: .categoryPinkLight),
                    MainCategory(description: "난 지금 양식이 땡긴다", name: "양식", image: UIImage(), color: .categoryYellowLight),
                    MainCategory(description: "내 손안의 이자카야", name: "일식", image: UIImage(), color: .categoryBlueLight)]
    
    private let titleLabel = UILabel().then {
        $0.text = "오늘도\n실패하지않는 레시피"
        $0.numberOfLines = 2
        $0.textColor = .white
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.bold.font(size: 26)
    }
    
    private let searchView = UIView().then {
        $0.cornerRadius = 25
        $0.backgroundColor = .searchBarBackgroudNavy
    }
    
    private let searchLabel = UILabel().then {
        $0.text = "원하는 메뉴를 검색해주세요"
        $0.textColor = .gray9A97A0
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.medium.font(size: 14)
    }
    
    private let searchIcon = UIImageView().then {
       // $0.image = UIImage.init(asset: .Image)
        $0.backgroundColor = .white
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.register(cell: MainCategoryCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
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
        self.view.backgroundColor = .backgroudNavy
    }
    
    private func setLayout() {
        
        self.view.addSubviews([titleLabel, searchView, collectionView])
        searchView.addSubviews([searchLabel, searchIcon])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            $0.height.equalTo(70)
            $0.leading.equalToSuperview().inset(25)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(410)
        }
          
        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(25)
        }
        
        searchIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(22)
        }
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
    }
}

// MARK: - CollectionView

extension MainVC {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(153/333),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(193/333))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(23)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 23
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.MainCategoryCollectionViewCell,
                                                            for: indexPath) as? MainCategoryCollectionViewCell else { fatalError() }
        cell.setData(mainCategory: mainCategories[indexPath.item])
        return cell
    }
    
}
