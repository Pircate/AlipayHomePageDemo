//
//  HomeViewController.swift
//  AlipayDemo
//
//  Created by gaoX on 2017/12/4.
//  Copyright © 2017年 adinnet. All rights reserved.
//

import UIKit
import SafariServices
import MJRefresh

var kScreenWidth = UIScreen.main.bounds.size.width
var kScreenHeight = UIScreen.main.bounds.size.height

class HomeViewController: UIViewController {
    
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
        let itemWidth = (kScreenWidth - 180) / 4.0
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 40
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 30, 10, 30)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: self.collectionViewHeight), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeUsualFeatureCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - self.navigation.bar.frame.maxY), style: .plain)
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(self.collectionViewHeight, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.collectionViewHeight, 0, 0, 0)
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
    
    lazy var searchTextField: UITextField = {
        let searchTextField = UITextField(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 28))
        searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        searchTextField.attributedPlaceholder = NSAttributedString(string: "   🔍 附近美食", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.white])
        searchTextField.isEnabled = false
        return searchTextField
    }()
    
    private var collectionViewHeight: CGFloat {
        let itemWidth = (kScreenWidth - 180) / 4.0
        return (itemWidth + 20) * 3 + 160
    }

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
            let originY = tableView.contentOffset.y + collectionViewHeight
            if originY > 0 {
                // 中间的collectionView随着tableView滚动
                collectionView.frame.origin.y = -originY
                
                // 导航栏渐变效果
                if collectionView.frame.origin.y > -64 {
                    let alpha = -collectionView.frame.origin.y / 64
                    headerView.contentView.alpha = 1 - alpha
                    searchTextField.alpha = 1 - alpha
                    updateNavigationItem(flag: false)
                }
                else {
                    updateNavigationItem(flag: true)
                }
            }
            else {
                collectionView.frame.origin.y = 0
                headerView.contentView.alpha = 1
                searchTextField.alpha = 1
            }
        }
    }
    
    // MARK: - private
    func setupNavigationItem() {
        navigation.bar.tintColor = UIColor.white
        navigation.bar.isTranslucent = false
        navigation.item.rightBarButtonItems = ["", ""].map({
            let item = UIBarButtonItem(title: $0, style: .plain, target: nil, action: nil)
            item.setTitleTextAttributes([.font: UIFont(name: "IconFont", size: 20)!], for: .normal)
            item.setTitleTextAttributes([.font: UIFont(name: "IconFont", size: 20)!], for: .highlighted)
            return item
        })
        
        updateNavigationItem(flag: false)
    }
    
    private func addSubviews() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(navigation.bar.snp.bottom)
            make.left.bottom.right.equalTo(view)
        }
        
        scrollView.addSubview(tableView)
        scrollView.addSubview(collectionView)
        
        // 禁止中间的collectionView滚动
        collectionView.isScrollEnabled = false
        
        // 移除父scrollView的所有手势
        scrollView.gestureRecognizers?.forEach({
            scrollView.removeGestureRecognizer($0)
        })
        
        // 将tableView的手势添加到父scrollView上
        tableView.gestureRecognizers?.forEach({
            scrollView.addGestureRecognizer($0)
        })
    }
    
    func updateNavigationItem(flag: Bool) {
        if flag {
            navigation.item.leftBarButtonItems = ["", "", "", ""].map({
                let item = UIBarButtonItem(title: $0, style: .plain, target: nil, action: nil)
                item.setTitleTextAttributes([.font: UIFont(name: "IconFont", size: 20)!], for: .normal)
                item.setTitleTextAttributes([.font: UIFont(name: "IconFont", size: 20)!], for: .highlighted)
                item.width = 32
                return item
            })
            navigation.item.titleView = nil
        }
        else {
            navigation.item.leftBarButtonItems = []
            navigation.item.titleView = searchTextField
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
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
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: 100)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let safariVC = SFSafariViewController(url: URL(string: "http://www.taobao.com")!)
        present(safariVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        cell?.textLabel?.text = "row: \(indexPath.row)"
        return cell!
    }
}
