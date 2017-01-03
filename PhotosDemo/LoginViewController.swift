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


extension URL {
    func getQueryItemValueForKey(key: String) -> String? {
        guard let components = NSURLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        guard let queryItems = components.queryItems else { return nil }
        return queryItems.filter {
            $0.name == key
            }.first?.value
    }
}

extension URL {
    var queryItems: [String: String]? {
        var params = [String: String]()
        return NSURLComponents(url: self as URL, resolvingAgainstBaseURL: false)?
            .queryItems?
            .reduce([:], { (_, item) -> [String: String] in
                params[item.name] = item.value
                return params
            })
    }
}

class LoginViewController: UIViewController, WKNavigationDelegate {

    // @IBOutlet weak var webView: UIWebView!
    
    private var webView: WKWebView?
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
        
        let urlString = "https://api.instagram.com/oauth/authorize/?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=token"
        
        webView?.loadUrl(string: urlString)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print(navigationAction.request.url!.host!)

        
        if navigationAction.request.url?.host == "github.com" {
            print("HIYA!")
            // print(navigationAction.request.url!.absoluteString)
            
            /*
            if let queryString = navigationAction.request.url?.queryItems {
                print(queryString)
                for (_, item) in queryString.enumerated() {
                    print(item.key)
                    print(item.value)
                }
            }
             */
            //print(navigationAction.request.url!.getQueryItemValueForKey(key: "access_token"))
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
