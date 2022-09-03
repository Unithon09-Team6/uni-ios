//
//  CategoryDetailViewController.swift
//  UNITHON-Team6-iOS
//
//  Created by 김혜수 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class CategoryDetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var detailCategories = ["전체", "메인요리", "국/찌개", "반찬"]
    var selected: Int = 0
    
    // MARK: - Components
    
    private let navigationBarView = UIView()
    private let navigationTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.semiBold.font(size: 18)
        $0.text = "한식"
    }
    private let backButton = UIButton().then {
        $0.backgroundColor = .white
    }
    private let searchButton = UIButton().then {
        $0.backgroundColor = .categoryPinkLight
    }
    
    private lazy var detailCategoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: createCategoryLayout())
        collectionView.register(cell: DetailCategoryCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var recipeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: createRecipeLayout())
        collectionView.register(cell: RecipeCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    init(category: MainCategory) {
        super.init(nibName: nil, bundle: nil)
        navigationTitleLabel.text = category.name
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setUI()
        setLayout()
        setCollectionView()
        
        API.searchCategoryRecipes("0", "").request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode(ResponseSearch.self, from: response.data) else {
                        return
                    }
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Function
    
    private func setUI() {
        self.view.backgroundColor = .backgroudNavy
    }
    
    private func setLayout() {
        
        view.addSubviews([navigationBarView, detailCategoryCollectionView, recipeCollectionView])
        navigationBarView.addSubviews([navigationTitleLabel, backButton, searchButton])
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(0)
            $0.height.width.equalTo(40)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(0)
            $0.width.height.equalTo(40)
        }
        
        detailCategoryCollectionView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        recipeCollectionView.snp.makeConstraints {
            $0.top.equalTo(detailCategoryCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        backButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        detailCategoryCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.selected = indexPath.item
                self?.detailCategoryCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    private func setCollectionView() {
        detailCategoryCollectionView.dataSource = self
        recipeCollectionView.dataSource = self
    }
}

// MARK: - CollectionView

extension CategoryDetailViewController {
    
    private func createCategoryLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .absolute(75),
            heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 11
        section.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 21, bottom: 13, trailing: 21)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createRecipeLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(153/333),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(224/333))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(23)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 23
        section.contentInsets = NSDirectionalEdgeInsets(top: 27, leading: 21, bottom: 27, trailing: 21)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailCategoryCollectionView {
            return detailCategories.count
        }
        else if collectionView == recipeCollectionView {
            return 10
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.DetailCategoryCollectionViewCell, for: indexPath) as? DetailCategoryCollectionViewCell else { fatalError() }
            cell.setData(category: detailCategories[indexPath.item],
                         isSelected: selected == indexPath.item)
            return cell
        }
        else if collectionView == recipeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.RecipeCollectionViewCell, for: indexPath) as? RecipeCollectionViewCell else { fatalError() }
            cell.setData()
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}
