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
    // redirectURI to match that configured on Instagram portal
    let redirectURI = "https://github.com/paynio/PhotosDemo"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView = WKWebView(frame:view.bounds)
        webView?.navigationDelegate = self
        view.addSubview(webView!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetcher = InstagramFetcher()
        
        guard let clientID = fetcher.clientID else {
            print("FAILED TO GET CLIENT ID")
            return
        }
        
        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=token&scope=public_content"
        //let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=token"

        webView?.loadUrl(string: urlString)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if url.host == "github.com" {
            print(navigationAction.request.url!)
            print("HIYA!")
            
            if let urlFragment = url.fragment {
                let accessToken = urlFragment.replacingOccurrences(of: "access_token=", with: "")
                UserDefaults.standard.setValue(accessToken, forKey: "instagramAccessToken")
                
                print(accessToken)
                self.dismiss(animated: true)
            }
            decisionHandler(.cancel)
        }
        
        decisionHandler(.allow)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
