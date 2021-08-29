//
//  sdf.swift
//  Devices
//
//  Created by iMac on 27.08.2021.
//

import UIKit
import WebKit
import SnapKit

class SVGImageView: UIView {
    
    private let webView = WKWebView()

    public init() {
        super.init(frame: .zero)
        
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = .scaleAspectFit

        webView.scrollView.frame = frame
        webView.layer.masksToBounds = false

        addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        webView.stopLoading()
    }

    public func load(urlString: String) {
        webView.stopLoading()
        
        let size = 375
        let htmlString = """
        <!DOCTYPE html>
        <html><head>
            <title>SVG via &lt;img&gt;</title>
        </head><body>
            <img src="\(urlString)" width="\(size)" height="\(size)">
        </body></html>
        """
        
        webView.loadHTMLString(htmlString, baseURL: NSURL() as URL)
    }
    
}
