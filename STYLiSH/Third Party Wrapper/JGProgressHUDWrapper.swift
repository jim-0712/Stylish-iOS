//
//  JGProgressHUDWrapper.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/3/6.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import JGProgressHUD

enum HUDType {
    
    case success(String)
    
    case failure(String)
}

class LKProgressHUD {
    
    static let shared = LKProgressHUD()
    
    private init(){ }
    
    let hud = JGProgressHUD(style: .dark)
    
    var view: UIView {
        
        return AppDelegate.shared.window!.rootViewController!.view
    }
    
    static func show(type: HUDType) {
        
        switch type {
        
        case .success(let text):
            
            showSuccess(text: text)
        
        case .failure(let text):
            
            showFailure(text: text)
        }
    }
    
    static func showSuccess(text: String = "success") {
        
        if !Thread.isMainThread {
            
            DispatchQueue.main.async {
                showSuccess(text: text)
            }
            
            return
        }
        
        shared.hud.textLabel.text = text
        
        shared.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        
        shared.hud.show(in: shared.view)
    
        shared.hud.dismiss(afterDelay: 2.0)
    }
    
    static func showFailure(text: String = "Failure") {
        
        if !Thread.isMainThread {
            
            DispatchQueue.main.async {
                showFailure(text: text)
            }
            
            return
        }
        
        shared.hud.textLabel.text = text
        
        shared.hud.indicatorView = JGProgressHUDErrorIndicatorView()
        
        shared.hud.show(in: shared.view)
        
        shared.hud.dismiss(afterDelay: 2.0)
    }
}
