//
//  UIView+AnimateExtensions.swift
//  JKEssential
//
//  Created by Trịnh Quân on 4/9/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation
import UIKit

public typealias AnimationBlock = () -> Void
public typealias AnimationCompletionBlock = (Bool) -> Void
public typealias AnimationCollection = [AnimationBlock]

public typealias AnimationDurationProviderBlock = (Int) -> TimeInterval
public typealias AnimationOptionsProviderBlock = (Int) -> UIViewAnimationOptions?

public extension UIView {
    
    public class func animateChain(_ animationCollection: AnimationCollection,
                                   loop: Bool = false,
                                   durations: [TimeInterval],
                                   defaultDuration: TimeInterval = 0.2,
                                   options: AnimationOptionsProviderBlock?,
                                   completion: AnimationCompletionBlock? = nil) -> AnimationChainTicket {
        return animateChain(animationCollection, loop: loop, durations: { animateAt in
            if durations.count < animateAt {
                return durations[animateAt]
            }
            return defaultDuration
        }, options: options, completion: completion)
    }
    
    public class func animateChain(_ animationCollection: AnimationCollection,
                                   loop: Bool = false,
                                   durations: @escaping AnimationDurationProviderBlock,
                                   options: AnimationOptionsProviderBlock?,
                                   completion: AnimationCompletionBlock? = nil) -> AnimationChainTicket {
        let optionsProvider = AnimationOptionsProviderByBlock(durationBlock: durations, optionsBlock: options)
        return animateChain(animationCollection,
                            loop: loop,
                            options: optionsProvider,
                            completion: completion)
    }
    
    public class func animateChain(_ animationCollection: AnimationCollection,
                                   loop: Bool = false,
                                   options: AnimationOptionsProviderProtocol,
                                   completion: AnimationCompletionBlock? = nil) -> AnimationChainTicket {
        let ticket = AnimationChainTicket(animationCollection, loop: loop, options: options, completion: completion)
        ticket.start()
        return ticket
    }
    
}

//MARK: - animation option provider
public protocol AnimationOptionsProviderProtocol{
    
    func animationDuration(forAnimationAt at: Int) -> TimeInterval
    
    func animationOptions(forAnimationAt at: Int) -> UIViewAnimationOptions?
    
}

public struct AnimationOptionsProviderByBlock: AnimationOptionsProviderProtocol {
    
    let durationBlock: AnimationDurationProviderBlock
    let optionsBlock: AnimationOptionsProviderBlock?
    
    public func animationDuration(forAnimationAt at: Int) -> TimeInterval {
        return durationBlock(at)
    }
    
    public func animationOptions(forAnimationAt at: Int) -> UIViewAnimationOptions? {
        return optionsBlock?(at) ?? UIViewAnimationOptions.allowUserInteraction
    }
}

struct AnimationOptionsProvider: AnimationOptionsProviderProtocol{
    
    let optionsProvider: AnimationOptionsProviderProtocol
    
    func animationDuration(forAnimationAt at: Int) -> TimeInterval {
        let duration = optionsProvider.animationDuration(forAnimationAt: at)
        return duration < 0 ? 0 : duration
    }
    
    func animationOptions(forAnimationAt at: Int) -> UIViewAnimationOptions? {
        return optionsProvider.animationOptions(forAnimationAt: at) ?? .allowUserInteraction
    }
    
}

//MARK: - animation chain ticket
public final class AnimationChainTicket{
    
    private var animationCollection: AnimationCollection
    private let animationCompletion: AnimationCompletionBlock?
    private let animationOptions: AnimationOptionsProvider
    
    let loop: Bool
    private var isRunning = false
    
    public init(_ animationCollection: AnimationCollection,
                loop: Bool = false,
                options: AnimationOptionsProviderProtocol,
                completion: AnimationCompletionBlock?) {
        self.animationOptions = AnimationOptionsProvider(optionsProvider: options)
        self.animationCollection = AnimationCollection()
        self.animationCollection.append(contentsOf: animationCollection)
        self.animationCompletion = completion
        self.loop = loop
    }
    
    internal func start(){
        isRunning = true
        if self.animationCollection.count == 0 {
            self.isRunning = false
            self.animationCompletion?(true)
            return
        }
        var animationCollection = AnimationCollection()
        animationCollection.append(contentsOf: self.animationCollection)
        let currentAnimation = animationCollection.remove(at: 0)
        animate(currentAnimation, index: 0, collection: animationCollection)
    }
    
    private func animate(_ animation: @escaping AnimationBlock, index: Int, collection: AnimationCollection){
        if !isRunning {
            animationCompletion?(false)
            return
        }
        UIView.animate(withDuration: animationOptions.animationDuration(forAnimationAt: index),
                       delay: 0,
                       options: animationOptions.animationOptions(forAnimationAt: index)!, animations: animation) { (completed) in
                        if !self.isRunning {
                            self.animationCompletion?(false)
                        } else if collection.count == 0 {
                            if self.loop {
                                self.start()
                            } else {
                                self.isRunning = false
                                self.animationCompletion?(true)
                            }
                        } else {
                            var collection = collection
                            let animation = collection.remove(at: 0)
                            self.animate(animation, index: index + 1, collection: collection)
                        }
        }
    }
    
    public func stop(){
        isRunning = false
    }
    
}
