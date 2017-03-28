//
//  TimeSpan.swift
//  JKEssential
//
//  Created by Trịnh Quân on 3/22/17.
//  Copyright © 2017 Trịnh Quân. All rights reserved.
//

import Foundation

public protocol TimeSpan {
    
    var interval: TimeInterval {get}
    
    var milliseconds: Double {get}
    
    var seconds: Double {get}
    
    var minutes: Double {get}
    
    var hours: Double {get}
    
    var roundedMiliseconds: Int {get}
    
    var roundedSeconds: Int {get}
    
    var roundedMinutes: Int {get}
    
    var roundedHours: Int {get}
}

public struct TimeSpans {
    
    private init(){}
    
    public static func from(interval: TimeInterval) -> TimeSpan {
        return IntervalTimeSpan(interval)
    }
    
    public static func from(milisecondes: Double) -> TimeSpan {
        return MilisecondTimeSpan(miliSeconds: milisecondes)
    }
    
    public static func from(seconds: Double) -> TimeSpan {
        return SecondTimeSpan(TimeInterval(seconds))
    }
    
    public static func from(minutes: Double) -> TimeSpan {
        return MinuteTimeSpan(minutes: minutes)
    }
    
    public static func from(hours: Double) -> TimeSpan {
        return HourTimeSpan(hours: hours)
    }
}

fileprivate class BaseTimeSpan: TimeSpan {
    
    let internalInterval: TimeInterval
    
    init(_ interval: TimeInterval) {
        self.internalInterval = interval
    }
    
    init(timeSpan: TimeSpan) {
        self.internalInterval = timeSpan.interval
    }
    
    var interval: TimeInterval {
        return internalInterval
    }
    
    var milliseconds: Double {
        return internalInterval * 1000
    }
    
    var seconds: Double {
        return internalInterval
    }
    
    var minutes: Double {
        return seconds / 60
    }
    
    var hours: Double {
        return seconds / 3600
    }
    
    var roundedMiliseconds: Int {
        return milliseconds.intValue
    }
    
    var roundedSeconds: Int {
        return seconds.intValue
    }
    
    var roundedMinutes: Int {
        return minutes.intValue
    }
    
    var roundedHours: Int {
        return hours.intValue
    }
}

fileprivate class IntervalTimeSpan : BaseTimeSpan {
}

fileprivate class MilisecondTimeSpan: BaseTimeSpan {
    
    private let internalMiliSeconds: Double
    
    init(miliSeconds: Double) {
        self.internalMiliSeconds = miliSeconds
        super.init(TimeInterval(miliSeconds) / 1000)
    }
    
    override var milliseconds: Double{
        return internalMiliSeconds
    }
}

fileprivate class SecondTimeSpan: IntervalTimeSpan{
    
}

fileprivate class MinuteTimeSpan: BaseTimeSpan{
 
    private let internalMinutes: Double
    
    init(minutes: Double) {
        self.internalMinutes = minutes
        super.init(TimeInterval(minutes * 60))
    }
    
    override var minutes: Double{
        return internalMinutes
    }
}

fileprivate class HourTimeSpan: BaseTimeSpan{

    private let internalHours: Double
    
    init(hours: Double) {
        self.internalHours = hours
        super.init(TimeInterval(hours * 3600))
    }
    
    override var hours: Double{
        return self.internalHours
    }
}












