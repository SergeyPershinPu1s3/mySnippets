//
//  KeyboardHandler.swift
//  PoseIt
//
//  Created by Evgeniya on 31.10.2019.
//  Copyright © 2019 Broadsay. All rights reserved.
//

import UIKit

class KeyboardHandler: NSObject {
    var keyboardWillAppear: ((_ height: CGFloat, _ animationDuration: CGFloat) -> ())?
    var keyboardWillDisappear: ((_ animationDuration: CGFloat) -> ())?
    private(set) var height : CGFloat = 0
    
    override init() {
        super.init()
        self.setupKeyboardObserver()
    }
    
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHandler.keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHandler.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let height = self.heightForKeyboardFromNotification(notification: notification),
            let duration = self.animationDurationForKeyboardFromNotification(notificaiton: notification) else {
                return
        }
        self.height = height
        self.keyboardWillAppear?(height, duration)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let animationDuration = self.animationDurationForKeyboardFromNotification(notificaiton: notification) else {
                return
        }
        self.height = 0
        self.keyboardWillDisappear?(animationDuration)
    }
    
    private func heightForKeyboardFromNotification(notification: NSNotification) -> CGFloat? {
        guard let info = notification.userInfo as? [String : AnyObject], let kbFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        let keyboardFrame = kbFrame.cgRectValue
        return keyboardFrame.size.height
    }
    
    private func animationDurationForKeyboardFromNotification(notificaiton: NSNotification) -> CGFloat? {
        guard let info = notificaiton.userInfo as? [String : AnyObject], let value = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSValue else {
            return nil
        }
        
        var duration:CGFloat = 0
        value.getValue(&duration)
        return duration
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.keyboardWillDisappear = nil
        self.keyboardWillAppear = nil
    }
}
