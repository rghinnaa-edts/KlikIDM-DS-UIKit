//
//  KlikColor.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 29/07/25.
//

import UIKit

extension Color {
    
    struct Neutral {
        static let whiteIDM = Color("WhiteIDM")
        static let blackIDM = Color("BlackIDM")
    }
    
    struct Grey {
        static let grey10 = Color("Grey-10")
        static let grey20 = Color("Grey-20")
        static let grey30 = Color("Grey-30")
        static let grey40 = Color("Grey-40")
        static let grey50 = Color("Grey-50")
        static let grey60 = Color("Grey-60")
        static let grey70 = Color("Grey-70")
    }
    
    struct Blue {
        static let blue10 = Color("Blue-10")
        static let blue20 = Color("Blue-20")
        static let blue30 = Color("Blue-30")
        static let blue40 = Color("Blue-40")
        static let blue50 = Color("Blue-50")
        static let blue60 = Color("Blue-60")
        static let blue70 = Color("Blue-70")
        static let blueTab = Color("BlueTab")
    }
    
    struct Yellow {
        static let yellow10 = Color("Yellow-10")
        static let yellow20 = Color("Yellow-20")
        static let yellow30 = Color("Yellow-30")
        static let yellow40 = Color("Yellow-40")
        static let yellow50 = Color("Yellow-50")
    }
    
    struct Red {
        static let red10 = Color("Red-10")
        static let red20 = Color("Red-20")
        static let red30 = Color("Red-30")
        static let red40 = Color("Red-40")
        static let red50 = Color("Red-50")
    }
    
    struct Green {
        static let green10 = Color("Green-10")
        static let green20 = Color("Green-20")
        static let green30 = Color("Green-30")
        static let green40 = Color("Green-40")
        static let green50 = Color("Green-50")
    }
    
    struct Orange {
        static let orange10 = Color("Orange-10")
        static let orange20 = Color("Orange-20")
        static let orange30 = Color("Orange-30")
        static let orange40 = Color("Orange-40")
        static let orange50 = Color("Orange-50")
    }
    
    struct Button {
        static let blueDefault = Color("Blue-Default")
        static let bluePressed = Color("Blue-Pressed")
        static let greyDefault = Color("Grey-Default")
        static let greyPressed = Color("Grey-Pressed")
        static let greyText = Color("Grey-Text")
        static let cartDefault = Color("Cart-Default")
        static let cartPressed = Color("Cart-Pressed")
        static let disabled = Color("Disabled")
    }
    
    struct Support {
        static let errorStrong = Color("Error-Strong")
        static let errorWeak = Color("Error-Weak")
        static let successStrong = Color("Success-Strong")
        static let successWeak = Color("Success-Weak")
        static let warningStrong = Color("Warning-Strong")
        static let warningWeak = Color("Warning-Weak")
    }
    
    struct Brand {
        static let xtra = Color("Xtra")
        static let xpress = Color("Xpress")
    }
    
    struct Gradient {
        static let sunset = LinearGradient(
            colors: [Color("Sunset-Start"), Color("Sunset-End")],
            startPoint: .leading,
            endPoint: .trailing)
        
        static let skyblue = LinearGradient(
            colors: [Color("Skyblue-Start"), Color("Skyblue-End")],
            startPoint: .leading,
            endPoint: .trailing)
        
        static let greenforest = LinearGradient(
            colors: [Color("Greenforest-Start"), Color("Greenforest-End")],
            startPoint: .leading,
            endPoint: .trailing)
        
        static let sunflower = LinearGradient(
            colors: [Color("Sunflower-Start"), Color("Sunflower-End")],
            startPoint: .leading,
            endPoint: .trailing)
    }
}
