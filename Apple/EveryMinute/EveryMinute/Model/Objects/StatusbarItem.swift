//
//  StatusbarItem.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 22.01.25.
//

import Foundation
import SwiftUI

internal struct StatusbarItem {
    
    internal var name : String
    
    internal var systemImage : String
    
    internal var displayed : Bool
    
    internal var position: Int
    
    internal var view : StatusBarItemView
    
    internal var dividerAfter : Bool = false
}

internal enum StatusBarItemView {
    case today
    case home
    case calendar
    case tasks
}
