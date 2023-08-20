//
//  UINavigationBarController+ProgressBar.swift
//  ProgressBarOnNavBar
//
//  Created by Luong Minh Hiep on 11/18/16.
//  Copyright © 2016 Luong Minh Hiep. All rights reserved.
//

import Foundation
import UIKit

import ObjectiveC

// Keys to set properties since we cannot define properties in a category.

var displayLinkKey: UInt8 = .zero
var animationFromKey: UInt8 = .zero
var animationToKey: UInt8 = .zero
var animationStartTimeKey: UInt8 = .zero
var progressKey: UInt8 = .zero
var progressViewKey: UInt8 = .zero
var isShowingProgressKey: UInt8 = .zero
var primaryColorKey: UInt8 = .zero
var secondaryColorKey: UInt8 = .zero
var backgroundColorKey: UInt8 = .zero
var backgroundViewKey: UInt8 = .zero

extension UINavigationController {
    
    private enum Constants {
        static var opaque = 1.0
        static var progressHeightSmall = 2.5
        static var progressHeightRegular = 5.0
        static var animationVeryShort = 0.1
        static var animationShort = 0.3
        static var animationRegular = 0.5
        static var animationLong = 1.0
    }
    
    // MARK: - Properties
    
    var displayLink: CADisplayLink? {
        get {
            return objc_getAssociatedObject(self, &displayLinkKey) as? CADisplayLink
        }
        set {
            objc_setAssociatedObject(self, &displayLinkKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var animationFromValue: Float {
        get {
            return (objc_getAssociatedObject(self, &animationFromKey) as?  Float) ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &animationFromKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var animationToValue: Float {
        get {
            return (objc_getAssociatedObject(self, &animationToKey) as?  Float) ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &animationToKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var animationStartTime: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &animationStartTimeKey) as?  TimeInterval) ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &animationStartTimeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var progress: Float {
        get {
            return (objc_getAssociatedObject(self, &progressKey) as?  Float) ?? .zero
        }
        set {
            var nextValue = newValue
            if (nextValue > 1.0) {
                nextValue = 1.0
            } else if (nextValue < .zero) {
                nextValue = .zero
            }

            objc_setAssociatedObject(self, &progressKey, nextValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            // Draw the update
            if Thread.isMainThread {
                self.updateProgress()
            } else {
                // Sometimes UINavigationController runs in a background thread. And drawing is not thread safe.
                DispatchQueue.main.async {
                    self.updateProgress()
                }
            }
        }
    }

    var isShowingProgressBar: Bool {
        get {
            return (objc_getAssociatedObject(self, &isShowingProgressKey) as?  Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &isShowingProgressKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var animationDuration: Float {
        get {
            return Float(Constants.animationShort)
        }
    }
    
    var progressView: UIView? {
        get {
            return objc_getAssociatedObject(self, &progressViewKey) as?  UIView
        }
        set {
            objc_setAssociatedObject(self, &progressViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var backgroundView: UIView? {
        get {
            return objc_getAssociatedObject(self, &backgroundViewKey) as?  UIView
        }
        set {
            objc_setAssociatedObject(self, &backgroundViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var primaryColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &primaryColorKey) as?  UIColor
        }
        set {
            objc_setAssociatedObject(self, &primaryColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var secondaryColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &secondaryColorKey) as?  UIColor
        }
        set {
            objc_setAssociatedObject(self, &secondaryColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var backgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &backgroundColorKey) as?  UIColor
        }
        set {
            objc_setAssociatedObject(self, &backgroundColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Progress
    func setProgress(_ progress: Float, animated: Bool) {
        var displayLink = self.displayLink
        if !animated {
            if displayLink != nil {
                displayLink?.invalidate()
                self.displayLink = nil
            }
            self.progress = progress
        } else {
            self.animationStartTime = CACurrentMediaTime()
            self.animationFromValue = self.progress
            self.animationToValue = progress
            if displayLink == nil {
                // Create and setup the display link
                displayLink?.invalidate()
                displayLink = CADisplayLink.init(target: self, selector: #selector(animateProgress(displayLink:)))
                self.displayLink = displayLink
                displayLink?.add(to: .main, forMode: RunLoop.Mode.common)
                
            }
        }
    }
    
    @objc func animateProgress( displayLink: CADisplayLink) {
        DispatchQueue.main.async {
            let dt = Double(Double(displayLink.timestamp) - self.animationStartTime)/Double(self.animationDuration)
            if dt >= Constants.animationLong {
                displayLink.invalidate()
                self.displayLink = nil
                self.progress = self.animationToValue
                return
            }
            
            // Set progress
            self.progress = Float(self.animationFromValue) + Float(dt) * (self.animationToValue - self.animationFromValue)
        }
    }
    
    func finishProgress() {
        let progressView = self.progressView
        let backgroundView = self.backgroundView
        if progressView != nil && backgroundView != nil {
            DispatchQueue.main.async {
                UIView .animate(withDuration: Constants.animationVeryShort, animations: {
                    var progressFrame = progressView?.frame
                    progressFrame?.size.width = self.navigationBar.frame.size.width
                    progressView?.frame = progressFrame!
                }, completion: { finished in
                    UIView .animate(withDuration: Constants.animationRegular, animations: {
                        progressView?.alpha = .zero
                        backgroundView?.alpha = .zero
                    }, completion: { finished in
                        progressView?.removeFromSuperview()
                        backgroundView?.alpha = Constants.opaque
                        progressView?.alpha = Constants.opaque
                        self.isShowingProgressBar = false
                    })
                })
            }
        }
    }
    
    func cancelProgress() {
        let progressView = self.progressView
        let backgroundView = self.backgroundView
        
        if progressView != nil && backgroundView != nil {
            DispatchQueue.main.async {
                UIView .animate(withDuration: 0.5, animations: {
                    progressView?.alpha = .zero
                    backgroundView?.alpha = .zero
                }, completion: { finished in
                    progressView?.removeFromSuperview()
                    backgroundView?.removeFromSuperview()
                    progressView?.alpha = Constants.opaque
                    backgroundView?.alpha = Constants.opaque
                    self.isShowingProgressBar = false
                })
            }
        }
    }
    
    // MARK: - Orientation
    func currentDeviceOrientation() -> UIInterfaceOrientation {
        let orientation: UIInterfaceOrientation
        if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
            orientation = UIInterfaceOrientation.portrait
        } else {
            orientation = UIInterfaceOrientation.landscapeLeft
        }
        return orientation
    }
    
    // MARK: - Drawing
    func showProgress() {
        let progressView = self.progressView
        let backgroundView = self.backgroundView
        UIView .animate(withDuration: 0.1, animations: {
            progressView?.alpha = Constants.opaque
            backgroundView?.alpha = Constants.opaque
        })
        self.isShowingProgressBar = true
    }
    
    func updateProgress() {
        self.updateProgressWithInterfaceOrientation(interfaceOrientation: self.currentDeviceOrientation())
    }
    
    private func updateProgressWithInterfaceOrientation(interfaceOrientation: UIInterfaceOrientation) {
        // Create the pregress view if it doesn't exist
        var progressView = self.progressView
        if progressView == nil {
            progressView = UIView.init(frame: CGRect(x: .zero, y: .zero, width: .zero, height: Constants.progressHeightSmall))
            progressView?.clipsToBounds = true
            self.progressView = progressView
        }
        
        if self.primaryColor != nil {
            progressView?.backgroundColor = self.primaryColor
        } else {
            progressView?.backgroundColor = self.navigationBar.tintColor
        }
        
        // Create background view if it doesn't exist
        var backgroundView = self.backgroundView
        if backgroundView == nil {
            backgroundView = UIView.init(frame: CGRect(x: .zero, y: .zero, width: .zero, height: Constants.progressHeightSmall))
            backgroundView?.clipsToBounds = true
            self.backgroundView = backgroundView
        }
        
        if self.backgroundColor != nil {
            backgroundView?.backgroundColor = self.backgroundColor
        } else {
            backgroundView?.backgroundColor = UIColor.clear
        }
        
        // Calculate the frame of the navigation bar, based off the orientation
        let topView = self.topViewController?.view
        let screenSize: CGSize
        if topView != nil {
            screenSize = topView!.bounds.size
        } else {
            screenSize = UIScreen.main.bounds.size
        }
        let width = interfaceOrientation.isLandscape ? Double(max(screenSize.width, screenSize.height)) : Double(min(screenSize.width, screenSize.height))
        let height = self.navigationBar.frame.size.height
               
        // Check if the progress view is in its superview and if we are showing the bar
        if progressView?.superview == nil && self.isShowingProgressBar {
            self.navigationBar.addSubview(backgroundView!)
            self.navigationBar.addSubview(progressView!)
        }
        
        // Calculate the width of the progress view
        let progressWidth = Float(width) * self.progress
        progressView?.frame = CGRect(x: .zero, y: Double(height - Constants.progressHeightRegular), width: Double(progressWidth), height: Double(Constants.progressHeightRegular))
        backgroundView?.frame = CGRect(x: .zero, y: height - Constants.progressHeightRegular, width: width, height: Constants.progressHeightRegular)
    }
    
    open override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.updateProgressWithInterfaceOrientation(interfaceOrientation: toInterfaceOrientation)
    }
}
