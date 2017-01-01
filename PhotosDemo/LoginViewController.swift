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

    // @IBOutlet weak var webView: UIWebView!
    
    private var webView: WKWebView?
    
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
        
        let redirectURI = "https://github.com/paynio/PhotosDemo"
        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=token"
        
        webView?.loadUrl(string: urlString)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print("HIYA!")
        print(navigationAction.request.url!.host!)

        guard (navigationAction.request.url?.host) != nil else {
            decisionHandler(.allow)
            return
        }
        
        // Registered my github URL as redirect uri on instagram.
        // Implied auth requires stripping of access token from such redirect uri
        
        if navigationAction.request.url!.host! == "github.com" {
            decisionHandler(.cancel)
            
            // GET access token
        }
        else {
            decisionHandler(.allow)
        }
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
