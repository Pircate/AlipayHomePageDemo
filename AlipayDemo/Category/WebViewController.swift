//
//  WebViewController.swift
//  iWeeB
//
//  Created by 高翔 on 2017/12/1.
//  Copyright © 2017年 GaoX. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - properties
    private var url = ""
    private var HTMLString = ""
    
    let configuration: WKWebViewConfiguration = {
        var source = """
            var meta = document.createElement('meta');
            meta.setAttribute('name', 'viewport');
            meta.setAttribute('content', 'width=device-width');
            document.getElementsByTagName('head')[0].appendChild(meta);
            """
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentCtrl = WKUserContentController()
        userContentCtrl.addUserScript(userScript)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentCtrl
        return configuration
    }()
    
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: self.ay_navigationBar.frame.maxY, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.ay_navigationBar.frame.maxY), configuration: self.configuration)
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: self.ay_navigationBar.frame.maxY, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.progressTintColor = .green
        progressView.trackTintColor = .clear
        return progressView
    }()
    
    // MARK: - life cycle
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    init(HTMLString: String) {
        super.init(nibName: nil, bundle: nil)
        self.HTMLString = HTMLString
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        disableAdjustsScrollViewInsets(webView.scrollView)
        addObserver()
        addSubviews()
        updateLeftNavigationBarItem()
        
        if !url.isEmpty {
            loadURLRequest()
        }
        else if !HTMLString.isEmpty {
            loadHTMLString()
        }
        else {
            loadFail()
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "canGoBack")
        webView.navigationDelegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - private
    private func addObserver() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
    }
    
    private func addSubviews() {
        view.addSubview(self.webView)
        view.addSubview(self.progressView)
        
        self.registerNavigationBar()
        self.ay_navigationBar.backgroundColor = .orange
        self.ay_navigationItem.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    private func updateLeftNavigationBarItem() {
        let backImg = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        let backBtn = UIButton(type: .system)
        backBtn.frame = CGRect(x: 0, y: 0, width: 38, height: 44)
        backBtn.setImage(backImg, for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        
        if webView.canGoBack {
            backBtn.frame = CGRect(x: 0, y: 0, width: 54, height: 44)
            backBtn.setTitle("返回", for: .normal)
            backBtn.setTitleColor(.white, for: .normal)
            backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
            
            let closeBtn = UIButton(type: .system)
            closeBtn.frame = CGRect(x: 0, y: 0, width: 35, height: 20)
            closeBtn.setTitle("关闭", for: .normal)
            closeBtn.setTitleColor(.white, for: .normal)
            closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            closeBtn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
            
            ay_navigationItem.leftBarItems = [backBtn, closeBtn]
        }
        else {
            ay_navigationItem.leftBarButton = backBtn
        }
    }
    
    private func loadURLRequest() {
        if url.isEmpty {
            loadFail()
            return
        }
        do {
            let dataDetector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            let result = dataDetector.firstMatch(in: url, options: .reportCompletion, range: NSMakeRange(0, url.count))
            if let URL = result?.url {
                let request = URLRequest(url: URL)
                webView.load(request)
            }
            else {
                loadFail()
                webView.loadHTMLString(url, baseURL: nil)
            }
        } catch {
            loadFail()
        }
    }
    
    private func loadHTMLString() {
        webView.loadHTMLString(HTMLString, baseURL: nil)
    }
    
    private func loadFail() {
        ay_navigationItem.title = "很抱歉，加载失败"
    }
    
    // MARK: - observe
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1 {
                UIView.animate(withDuration: 0.25, animations: {
                    self.progressView.transform = .identity
                }, completion: { (finished) in
                    self.progressView.isHidden = true
                })
            }
        }
        if keyPath == "title" {
            ay_navigationItem.title = webView.title
        }
        if keyPath == "canGoBack" {
            updateLeftNavigationBarItem()
        }
    }
    
    // MARK: - action
    @objc private func backBtnAction() {
        if webView.canGoBack {
            webView.goBack()
            return
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeBtnAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        view.bringSubview(toFront: progressView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }

}
