//
//  RecipesDetailViewController.swift
//  UNITHON-Team6-iOS
//
//  Created by 김대희 on 2022/09/03.
//  Copyright © 2022 com.UNITHON-Team6. All rights reserved.
//

import UIKit

class RecipesDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return RecipesDetailTableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return tableView.rowHeight
       }


    
    private let navigationBarView = UIView()
    
    private let backButton = UIButton().then {
        $0.backgroundColor = .white
    }
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.font = PretendardFont.medium.font(size: 16)
    }
    
    private let productNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = PretendardFont.bold.font(size: 30)
    }
    
    private let totalCountView = UIView().then {
        $0.backgroundColor = .color372F44
        $0.layer.cornerRadius = 20
    }
    
    private let totalCountImageView = UIImageView().then {
        $0.backgroundColor = .categoryPinkLight
    }
    
    private let totalCountLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.font = PretendardFont.medium.font(size: 14)
    }
    
    private let detailView = UIView().then {
        $0.backgroundColor = .color372F44
        $0.layer.cornerRadius = 20
    }
    
    private let detailImageView = UIImageView().then {
        $0.backgroundColor = .categoryPinkLight
    }
    private let detailTitleLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.font = PretendardFont.medium.font(size: 14)
    }
    
    private let detailContentLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.numberOfLines = 0
        $0.font = PretendardFont.medium.font(size: 14)
    }
    
    private let timerListLabel = UILabel().then {
        $0.textColor = .colorF4F4F4
        $0.font = PretendardFont.bold.font(size: 16)
    }
    
    private let timerListTableView = ContentWrappingTableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    
    let startButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("이 래시피로 요리하기", for: .normal)
        $0.backgroundColor = .categoryPurpleLight
        $0.layer.cornerRadius = 27

    }
    
    override func configureUI() {
        view.backgroundColor = .backgroudNavy
        
        imageView.backgroundColor = .categoryPinkLight
        titleLabel.text = "제목이 들어가요"
        productNameLabel.text = "제품명이 들어가요"
        totalCountLabel.text = "총 소요시간 00분"
        detailTitleLabel.text = "준비 재료 : "
        timerListLabel.text = "타이머 리스트"
        detailContentLabel.text = "밥 2공기(400g), 배추김치 200g,\n스팸80g, 대파1/2대, 달걀 3개\n,김칫국물 2큰술, 간장 1큰술\n,참기름 1큰술, 고춧가루 1/2큰술\n,깨소름 1/2 큰술, 후춧가루 약간,\n김가루 약간, 식용류 적당량"
        
        timerListTableView.delegate = self
        timerListTableView.dataSource = self
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubviews([scrollView, navigationBarView, startButton])
        navigationBarView.addSubview(backButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews([imageView, titleLabel, productNameLabel, totalCountView, detailView, timerListLabel, timerListTableView])
        totalCountView.addSubviews([totalCountLabel, totalCountImageView])
        detailView.addSubviews([detailImageView, detailTitleLabel, detailContentLabel])
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view) }
        contentView.snp.makeConstraints { $0.edges.width.equalTo(self.scrollView) }
        
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(0)
            $0.height.width.equalTo(40)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(400)
            $0.leading.trailing.equalTo(0)
            $0.top.equalTo(0)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(14)
            $0.height.equalTo(54)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)

        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(0).inset(25)
            $0.height.equalTo(19)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(36)
            $0.leading.trailing.equalTo(0).inset(25)
        }
        
        totalCountView.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.top.equalTo(productNameLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(0).inset(25)
        }
        
        totalCountImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(0).inset(20)
            $0.left.equalTo(17)
            $0.width.height.equalTo(30)
        }
        
        totalCountLabel.snp.makeConstraints {
            $0.left.equalTo(totalCountImageView.snp.right).offset(6)
            $0.centerY.equalToSuperview()
        }
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(totalCountView.snp.bottom).offset(25)
            $0.leading.trailing.equalTo(0).inset(25)
        }
        
        detailImageView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(17)
            $0.width.height.equalTo(30)
        }
        
        detailTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(detailImageView)
            $0.left.equalTo(detailImageView.snp.right).offset(6)
            $0.height.equalTo(17)
        }
        
        detailContentLabel.snp.makeConstraints {
            $0.top.equalTo(detailTitleLabel.snp.top)
            $0.bottom.equalTo(-20)
            $0.left.equalTo(detailTitleLabel.snp.right)
            $0.right.equalTo(-11)
        }
        
        timerListLabel.snp.makeConstraints {
            $0.top.equalTo(detailView.snp.bottom).offset(40)
            $0.leading.trailing.equalTo(0).inset(25)
            $0.height.equalTo(19)
        }
        timerListTableView.snp.makeConstraints {
            $0.top.equalTo(timerListLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(0)
            $0.bottom.equalTo(-10)
        }
        timerListTableView.rowHeight = UITableView.automaticDimension
    }
}
