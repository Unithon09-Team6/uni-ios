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
    
    var detailCategories: [Subs]?
    var selectedSubCategory: Int = 0
    var recipies: [Recipes]?
    
    /// 현재 큰 카테고리
    ///  0: 한식, 1: 중식, 2:양식, 3:일식
    var nowCategory: Int?
    
    // MARK: - Components
    
    private let navigationBarView = UIView()
    private let navigationTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UNITHONTeam6IOSFontFamily.Pretendard.semiBold.font(size: 18)
        $0.text = "한식"
    }
    private let backButton = UIButton().then {
        $0.setImage(UNITHONTeam6IOSAsset.Assets.iconArrowBack.image, for: .normal)
        
    }
    private let searchButton = UIButton().then {
        $0.setImage(UNITHONTeam6IOSAsset.Assets.iconSearchWhite.image, for: .normal)
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
        nowCategory = category.number
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
        if let nowCategory = nowCategory {
            getAllCategory(category: nowCategory)
            getSubCategory(category: nowCategory)
        }
        
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
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
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
                self?.selectedSubCategory = indexPath.item
                if let detailCategories = self?.detailCategories {
                    if indexPath.item == 0 {
                        self?.getAllCategory(category: self?.nowCategory ?? 0)
                    } else {
                        self?.getSubCategoryRecipies(subCategoryID: detailCategories[indexPath.item]._id)
                    }
                }
                self?.detailCategoryCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        recipeCollectionView.rx.itemSelected
            .bind { indexPath in
                let recipesDetailViewController = RecipesDetailViewController()
                self.navigationController?.pushViewController(recipesDetailViewController, animated: true)
            }
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .withUnretained(self)
            .bind { _ in
                self.navigationController?.pushViewController(SearchViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func setCollectionView() {
        detailCategoryCollectionView.dataSource = self
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
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
            widthDimension: .fractionalWidth(75/375),
            heightDimension: .absolute(30))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = UIScreen.main.bounds.width * (11/375)
        section.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 21, bottom: 13, trailing: 21)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
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

extension CategoryDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == detailCategoryCollectionView {
            return detailCategories?.count ?? 0
        }
        else if collectionView == recipeCollectionView {
            return recipies?.count ?? 0
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == detailCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.DetailCategoryCollectionViewCell, for: indexPath) as? DetailCategoryCollectionViewCell else { fatalError() }
            if let detailCategories = detailCategories {
                cell.setData(category: detailCategories[indexPath.item].subCategory,
                             isSelected: selectedSubCategory == indexPath.item)
            }
            return cell
        }
        else if collectionView == recipeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.RecipeCollectionViewCell, for: indexPath) as? RecipeCollectionViewCell else { fatalError() }
            if let recipies = recipies {
                cell.setData(recipe: recipies[indexPath.item])
            }
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recipeCollectionView {
            let recipesDetailViewController = RecipesDetailViewController()
            self.navigationController?.pushViewController(recipesDetailViewController, animated: true)
            recipesDetailViewController.title = recipies?[indexPath.row].title
            recipesDetailViewController.productName = recipies?[indexPath.row].productName ?? ""
            recipesDetailViewController.detail = recipies?[indexPath.row].detail ?? ""
            recipesDetailViewController.pictureURL = recipies?[indexPath.row].picUrl ?? ""
            recipesDetailViewController.totalCount = recipies?[indexPath.row].totalCount ?? 0
            recipesDetailViewController.timer = recipies?[indexPath.row].timer ?? []
        }
    }
    
}

// MARK: - Network

extension CategoryDetailViewController {
    
    private func getAllCategory(category: Int) {
        API.searchCategoryRecipes("\(category)", "").request()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode(ResponseSearch.self, from: response.data) else {
                        fatalError()
                    }
                    print("data", data)
                    self?.recipies = data.list
                    self?.recipeCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getSubCategory(category: Int) {
        API.getSubCategoryList(("\(category)")).request()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode([Subs].self, from: response.data) else {
                        fatalError()
                    }
                    print("data", data)
                    self?.detailCategories = [Subs(_id: "all", category: 1000, subCategory: "전체")] + data
                    self?.detailCategoryCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getSubCategoryRecipies(subCategoryID: String) {
        API.getSubCategory(subCategoryID).request()
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode([Recipes].self, from: response.data) else {
                        fatalError()
                    }
                    self?.recipies = data
                    self?.recipeCollectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
