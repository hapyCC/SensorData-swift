//
//  Swizzle.swift
//  Swizzle
//
//  Created by Yasuhiro Inami on 2014/09/14.
//  Copyright (c) 2014年 Yasuhiro Inami. All rights reserved.
//

import ObjectiveC

private func _swizzleMethod(_ class_: AnyClass, from selector1: Selector, to selector2: Selector, isClassMethod: Bool)
{
    let c: AnyClass
    if isClassMethod {
        guard let c_ = object_getClass(class_) else {
            return
        }
        c = c_
    }
    else {
        c = class_
    }

//    guard let method1: Method = class_getInstanceMethod(c, selector1),
//        let method2: Method = class_getInstanceMethod(c, selector2) else
//    {
//        return
//    }
//
//    if class_addMethod(c, selector1, method_getImplementation(method2), method_getTypeEncoding(method2)) {
//        class_replaceMethod(c, selector2, method_getImplementation(method1), method_getTypeEncoding(method1))
//    }
//    else {
//        method_exchangeImplementations(method1, method2)
//    }
    __swizzleClassMethod(c, selector1: selector1, to: c, selector2: selector2)
}

private func _swizzleTwoMethod(_ fromClass_: AnyClass, from selector1: Selector, to toClass_: AnyClass, selector2: Selector, isClassMethod: Bool)
{
    let f: AnyClass
    if isClassMethod {
        guard let f_ = object_getClass(fromClass_) else {
            return
        }
        f = f_
    }
    else {
        f = fromClass_
    }

    let t: AnyClass
    if isClassMethod {
        guard let t_ = object_getClass(toClass_) else {
            return
        }
        t = t_
    }
    else {
        t = toClass_
    }
   
    __swizzleClassMethod(f, selector1: selector1, to: t, selector2: selector2)
}

private func __swizzleClassMethod(_ f: AnyClass, selector1: Selector, to t: AnyClass, selector2: Selector) {
    guard let method1: Method = class_getInstanceMethod(f, selector1),
        let method2: Method = class_getInstanceMethod(t, selector2) else
    {
        return
    }

    if class_addMethod(f, selector1, method_getImplementation(method2), method_getTypeEncoding(method2)) {
        class_replaceMethod(t, selector2, method_getImplementation(method1), method_getTypeEncoding(method1))
    }
    else {
        method_exchangeImplementations(method1, method2)
    }
}

/// Instance-method swizzling.
public func swizzleInstanceMethod(_ class_: AnyClass, from sel1: Selector, to sel2: Selector)
{
    _swizzleMethod(class_, from: sel1, to: sel2, isClassMethod: false)
}

/// Instance-method swizzling for unsafe raw-string.
/// - Note: This is useful for non-`#selector`able methods e.g. `dealloc`, private ObjC methods.
public func swizzleInstanceMethodString(_ class_: AnyClass, from sel1: String, to sel2: String)
{
    swizzleInstanceMethod(class_, from: Selector(sel1), to: Selector(sel2))
}

/// Class-method swizzling.
public func swizzleClassMethod(_ class_: AnyClass, from sel1: Selector, to sel2: Selector)
{
    _swizzleMethod(class_, from: sel1, to: sel2, isClassMethod: true)
}

/// Class-method swizzling for unsafe raw-string.
public func swizzleClassMethodString(_ class_: AnyClass, from sel1: String, to sel2: String)
{
    swizzleClassMethod(class_, from: Selector(sel1), to: Selector(sel2))
}


/// class-method swizzling with two class
public func swizzleTwoInstanceMethod(_ fromClass: AnyClass, from sel1: Selector, to toClass: AnyClass, sel2: Selector) {
    _swizzleTwoMethod(fromClass, from: sel1, to: toClass, selector2: sel2, isClassMethod: false)
}
