//
//  Extension.swift
//  SensorData-swift
//
//  Created by Apple on 11/2/22.
//

import Foundation
import UIKit


/// 点击事件
extension UIApplication {
    class func swizzleMethod() {
        swizzleInstanceMethod(UIApplication.self, from: #selector(sendAction(_:to:from:for:)), to: #selector(sensorData_sendAction(_:to:from:for:)))

        UITableView.swizzleMethod()
        UICollectionView.swizzleMethod()
        UILongPressGestureRecognizer.swizzleMethod()
        UITapGestureRecognizer.swizzleMethod()
    }
    
    @objc func sensorData_sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
        
        print("~sensorData_sendAction~");
        // track data
        return sensorData_sendAction(action, to: target, from: sender, for: event)
    }
    
}


/// 列表
extension UITableView {
    
    class func swizzleMethod() {
        swizzleInstanceMethod(UITableView.self, from: #selector(setter: UITableView.delegate), to: #selector(sensorData_delegate(_:)))
        
    }
    
    @objc func sensorData_delegate(_ delegate: UITableViewDelegate) {
        sensorData_delegate(delegate)
        sensorData_swizzleDidSelectRowAtIndexPathMethodWithDelegate(delegate: delegate)
    }
    
    func sensorData_swizzleDidSelectRowAtIndexPathMethodWithDelegate(delegate: UITableViewDelegate) {

        let sourceSelector = #selector(delegate.tableView(_:didSelectRowAt:))
        
        if !delegate.responds(to: sourceSelector) {
            return
        }
        
        let destinationSelector = #selector(sensorData_tableView(_:didSelectRowAt:))
        if (delegate.responds(to: destinationSelector)) {
            return
        }
        
        swizzleTwoInstanceMethod(type(of: delegate), from: sourceSelector, to: UITableView.self, sel2: destinationSelector)
    }
    
    @objc func sensorData_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("##")
        // track data
        
        tableView.sensorData_tableView(tableView, didSelectRowAt: indexPath)
    }
}

extension UICollectionView {
    class func swizzleMethod() {
        swizzleInstanceMethod(UICollectionView.self, from: #selector(setter: UICollectionView.delegate), to: #selector(sensorData_delegate(_:)))
        
    }
    
    @objc func sensorData_delegate(_ delegate: UICollectionViewDelegate) {
        sensorData_delegate(delegate)
        sensorData_swizzleDidSelectRowAtIndexPathMethodWithDelegate(delegate: delegate)
    }
    
    func sensorData_swizzleDidSelectRowAtIndexPathMethodWithDelegate(delegate: UICollectionViewDelegate) {

        let sourceSelector = #selector(delegate.collectionView(_:didSelectItemAt:))
        
        if !delegate.responds(to: sourceSelector) {
            return
        }
        
        let destinationSelector = #selector(sensorData_collectionView(_:didSelectItemAt:))
        if (delegate.responds(to: destinationSelector)) {
            return
        }
        
        swizzleTwoInstanceMethod(type(of: delegate), from: sourceSelector, to: UICollectionView.self, sel2: destinationSelector)
    }
    
    
    @objc func sensorData_collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("##")
        // track data
        
        collectionView.sensorData_collectionView(collectionView, didSelectItemAt: indexPath)
    }

}



/// 手势
extension UILongPressGestureRecognizer {
    
    class func swizzleMethod() {
        let originalSel = NSSelectorFromString("initWithTarget:action:")
        let destinationSel = #selector(sensorData_init(target:action:))
        swizzleInstanceMethod(UILongPressGestureRecognizer.self, from: originalSel, to: destinationSel)

        let originalSel1 = #selector(addTarget(_:action:))
        let destinationSel1 = #selector(sensorData_addTarget(_:action:))
        swizzleInstanceMethod(UILongPressGestureRecognizer.self, from: originalSel1, to: destinationSel1)
    }
    
    @objc func sensorData_init(target: Any?, action: Selector?) -> Self {
        _ = sensorData_init(target: target, action: action)
        addTarget(target as Any, action: action!)
        return self
    }
        
    @objc func sensorData_addTarget(_ target: Any, action: Selector) {
        sensorData_addTarget(target, action: action)
        sensorData_addTarget(self, action: #selector(sensorData_longGestureAction(gesture:)))
    }
    
    @objc func sensorData_longGestureAction(gesture: UILongPressGestureRecognizer) {
        print("sensorData_longGestureAction")
        // track longGesture action
    }
}

extension UITapGestureRecognizer {
    class func swizzleMethod() {
        let originalSel = NSSelectorFromString("initWithTarget:action:")
        let destinationSel = #selector(sensorData_init(target:action:))
        swizzleInstanceMethod(UITapGestureRecognizer.self, from: originalSel, to: destinationSel)

        let originalSel1 = #selector(addTarget(_:action:))
        let destinationSel1 = #selector(sensorData_addTarget(_:action:))
        swizzleInstanceMethod(UITapGestureRecognizer.self, from: originalSel1, to: destinationSel1)
    }
    
    @objc func sensorData_init(target: Any?, action: Selector?) -> Self {
        _ = sensorData_init(target: target, action: action)
        addTarget(target as Any, action: action!)
        return self
    }
        
    @objc func sensorData_addTarget(_ target: Any, action: Selector) {
        sensorData_addTarget(target, action: action)
        sensorData_addTarget(self, action: #selector(sensorData_tapGestureAction(gesture:)))
    }
    
    @objc func sensorData_tapGestureAction(gesture: UITapGestureRecognizer) {
        print("sensorData_tapGestureAction")
        // track longGesture action
    }
}


extension UIViewController: NSSwiftyLoadProtocol {
    
    public static func swiftyLoad() {
        UIViewController.swizzleMethod()
    }

    class func swizzleMethod() {
        let originalSel = #selector(UIViewController.viewWillAppear(_:))
        let destinationSel = #selector(sensorData_viewWillAppear(_:))
        swizzleInstanceMethod(UIViewController.self, from: originalSel, to: destinationSel)
    }
    
    @objc func sensorData_viewWillAppear(_ animated: Bool) {
        print("sensorData_viewWillAppear")
    }
}


extension UIView {

    var elementType: String {
        return NSStringFromClass(type(of: self))
    }
    
    var elementContent: String? {
        if self.isHidden == true || self.alpha == 0 {
            return nil
        }
        
        if self.isKind(of: UIButton.self) {
            return (self as! UIButton).titleLabel?.text
        } else if self.isKind(of: UISwitch.self) {
            return (self as! UISwitch).isOn ? "checked" : "unchecked"
        } else if self.isKind(of: UILabel.self) {
            return (self as! UILabel).text
        }
        let contents = NSMutableArray()
        for view in self.subviews {
                let content = view.elementContent
                if content?.isKind(of: NSString.self) == true {
                    if content!.count > 0 {
                        contents.add(content! as NSString)
                    }
                }
        }
        return contents.count == 0 ? nil : contents.componentsJoined(by: "-")
    }
    
    
    var elementViewController: UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}){
            if let responder = view?.next{
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
}

