//
//  HomeViewController.swift
//  AlipayDemo
//
//  Created by 高翔 on 2017/12/4.
//  Copyright © 2017年 adinnet. All rights reserved.
//

import UIKit
import MJRefresh

var kScreenWidth = UIScreen.main.bounds.size.width
var kScreenHeight = UIScreen.main.bounds.size.height

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {
    
    var usualFeatures = [["featureName": "转账",
                          "featureIcon": ""],
                         ["featureName": "信用卡还款",
                          "featureIcon": ""],
                         ["featureName": "余额宝",
                          "featureIcon": ""],
                         ["featureName": "生活缴费",
                          "featureIcon": ""],
                         ["featureName": "我的快递",
                          "featureIcon": ""],
                         ["featureName": "天猫",
                          "featureIcon": ""],
                         ["featureName": "AA收款",
                          "featureIcon": ""],
                         ["featureName": "上银汇款",
                          "featureIcon": ""],
                         ["featureName": "爱心捐赠",
                          "featureIcon": ""],
                         ["featureName": "彩票",
                          "featureIcon": ""],
                         ["featureName": "游戏中心",
                          "featureIcon": ""],
                         ["featureName": "更多",
                          "featureIcon": ""],]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 40
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 320), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(HomeUsualFeatureCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - self.ay_navigationBar.frame.maxY), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsetsMake(320, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(320, 0, 0, 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                tableView.mj_header.endRefreshing()
            })
        })
        return tableView
    }()
    
    lazy var headerView: HomeCommonFeatureView = {
        let headerView = HomeCommonFeatureView(frame: .zero)
        return headerView
    }()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableAdjustsScrollViewInsets(scrollView)
        disableAdjustsScrollViewInsets(tableView)
        disableAdjustsScrollViewInsets(collectionView)
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        setupNavigationItem()
        addSubviews()
    }
    
    deinit {
        tableView.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if tableView.contentOffset.y + 320 > 0 {
                collectionView.frame.origin.y = -(tableView.contentOffset.y + 320)
                if collectionView.frame.origin.y > -64 {
                    let alpha = -collectionView.frame.origin.y / 64
                    headerView.contentView.alpha = 1 - alpha
                    updateNavigationItem(flag: false)
                }
                else {
                    updateNavigationItem(flag: true)
                }
            }
            else {
                collectionView.frame.origin.y = 0
                headerView.contentView.alpha = 1
            }
        }
    }
    
    // MARK: - private
    func setupNavigationItem() {
        
        let moreBtn = UIButton(type: .system)
        moreBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        moreBtn.titleLabel?.font = UIFont(name: "IconFont", size: 18)
        moreBtn.setTitle("", for: .normal)
        moreBtn.setTitleColor(.white, for: .normal)
        
        let friendBtn = UIButton(type: .system)
        friendBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        friendBtn.titleLabel?.font = UIFont(name: "IconFont", size: 18)
        friendBtn.setTitle("", for: .normal)
        friendBtn.setTitleColor(.white, for: .normal)
        
        let fixedSpace = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        ay_navigationItem.rightBarItems = [moreBtn, friendBtn, fixedSpace]
        
        updateNavigationItem(flag: false)
    }
    
    private func addSubviews() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(ay_navigationBar.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
        
        scrollView.addSubview(tableView)
        scrollView.addSubview(collectionView)
        
        if let gestures = scrollView.gestureRecognizers {
            for gesture in gestures {
                scrollView.removeGestureRecognizer(gesture)
            }
        }
        
        if let gestures = tableView.gestureRecognizers {
            for gesture in gestures {
                scrollView.addGestureRecognizer(gesture)
            }
        }
    }
    
    func updateNavigationItem(flag: Bool) {
        if flag {
            let itemTitles = ["", "", "", ""]
            var items = [UIView]()
            for title in itemTitles {
                let btn = UIButton(type: .system)
                btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                btn.titleLabel?.font = UIFont(name: "IconFont", size: 18)
                btn.setTitle(title, for: .normal)
                btn.setTitleColor(.white, for: .normal)
                items.append(btn)
            }
            ay_navigationItem.leftBarItems = items
            ay_navigationItem.titleView = nil
        }
        else {
            let searchBtn = UIButton(type: .custom)
            searchBtn.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 24)
            searchBtn.setBackgroundImage(UIImage(named: "home_nav_search_background"), for: .normal)
            searchBtn.setBackgroundImage(UIImage(named: "home_nav_search_background"), for: .highlighted)
            ay_navigationItem.titleView = searchBtn
            ay_navigationItem.titleViewStyle = .automatic
            
            ay_navigationItem.leftBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usualFeatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeUsualFeatureCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HomeUsualFeatureCell
        cell.setupUsualFeatureInfo(info: usualFeatures[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
        header.addSubview(headerView)
        return header
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (kScreenWidth - 180) / 4.0
        return CGSize(width: itemWidth, height: itemWidth + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: 100)
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(WebViewController(url: "www.sina.com"), animated: true)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
}
