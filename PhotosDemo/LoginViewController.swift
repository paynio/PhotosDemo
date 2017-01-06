//
//  LoginViewController.swift
//  PhotosDemo
//
//  Created by Daniel Payne on 01/01/2017.
//  Copyright © 2017 Daniel Payne. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView {
    func loadUrl(string: String) {
        if let url = URL(string: string) {
            load(URLRequest(url: url))
        }
    }
}

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView?
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // redirectURI to match that configured on Instagram portal
    
    let redirectURI = "https://github.com/paynio/PhotosDemo"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let frame = CGRect(x: 0, y: 0, width: self.webViewContainer.frame.size.width, height: self.webViewContainer.frame.size.height)
        self.webView = WKWebView(frame:frame)
        self.webView?.navigationDelegate = self
        self.webViewContainer.addSubview(webView!)
        self.webViewContainer.bringSubview(toFront: self.activityIndicator)
        self.activityIndicator.startAnimating()
        
        guard let clientID = CredsFetcher().getCred(forInstaCred: .ClientID) else {
            print("FAILED TO GET CLIENT ID")
            return
        }
        
        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=token"
        webView?.loadUrl(string: urlString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - WKNavigationDelegate

extension LoginViewController {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if url.host == "github.com" {
            
            if let urlFragment = url.fragment {
                let accessToken = urlFragment.replacingOccurrences(of: "access_token=", with: "")
                UserDefaults.standard.setValue(accessToken, forKey: "instagramAccessToken")
                
                self.dismiss(animated: true)
            }
            decisionHandler(.cancel)
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Pre-populates the webView with creds from Creds.plist. This is to help smooth the login process.
        // This is just to help you login with the demo: it should never be placed anywhere near production code!
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        
        let creds = CredsFetcher()
        
        guard let username = creds.getCred(forInstaCred: .UserName),
            let password = creds.getCred(forInstaCred: .Password) else {
                return
        }
        
        webView.evaluateJavaScript("document.getElementById('id_username').value= '\(username)'") { (res, error) in
            webView.evaluateJavaScript("document.getElementById('id_password').value= '\(password)'") { (res, error) in
                webView.evaluateJavaScript("document.querySelector('input[type=submit]').click();") { (res, error) in
                    
                }
            }
        }
    }
}
