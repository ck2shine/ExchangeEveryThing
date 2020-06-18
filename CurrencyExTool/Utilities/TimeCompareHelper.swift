//
//  TimeCompareHelper.swift
//  CurrencyExTool
//
//  Created by i9400503 on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class TimeCompareHelper{
    final class func compareTimeIsExceed(startTime : TimeInterval , endTime : TimeInterval , limitMinutes : Int)-> Bool{
        let startTime =  Date(timeIntervalSince1970: startTime)
        let endTime =  Date(timeIntervalSince1970: endTime)

        let calender:Calendar = Calendar.current
        let components: DateComponents = calender.dateComponents([ .minute, .second], from: startTime, to: endTime)

        return  components.minute ?? 0  > limitMinutes
    }
}
