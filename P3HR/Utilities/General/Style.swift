//
//  Style.swift
//  meeApp
//
//  Created by Jonah Pacas on 09/03/2018.
//  Copyright © 2018 CoderScoop. All rights reserved.
//

import UIKit

public enum ThemeColorKey {
    case unknown
    
    case windowTint
    
    case loginButtonTint
    
    case buttonTint
    case fabTint
    
    case plumColor
    case tealColor
    case darkTealColor
    case greenColor
    case blueColor
    case grayColor
    case charcoalGrayColor
    case orangeColor
    case brownColor
    case veryLigthGray
    
    case meeButtonBg
    case meeButtonBorder
    
    case textFieldLabel
    case buttonTitleNormal
    case buttonDisabled
    case buttonTitleDisabled
    case formDivider
    case iconButtonTintSecondary
    case infoIconTint
    
    case formFieldTextColor
    case formFieldPlaceholderActiveColor
    case formFieldPlaceholderNormalColor
    case formFieldDividerNormalColor
    case formFieldDividerActiveColor
    case formFieldBorderActiveColor
    case formFieldBorderNormalColor
    
    case appBackgroundColor
    
}

public class Styles {
    
    public static func color(forKey key: ThemeColorKey) -> UIColor {
        switch key {
        case .windowTint:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .loginButtonTint:
            return #colorLiteral(red: 0.2745098039, green: 0.09019607843, blue: 0.2078431373, alpha: 1)
        case .buttonTint,
             .fabTint,
             .greenColor:
            return #colorLiteral(red: 0, green: 0.6823529412, blue: 0.6196078431, alpha: 1)
        case .plumColor:
            return #colorLiteral(red: 0.2745098039, green: 0.09019607843, blue: 0.2117647059, alpha: 1)
        case .tealColor:
            return #colorLiteral(red: 0.1764705882, green: 0.5098039216, blue: 0.6431372549, alpha: 1)
        case .darkTealColor:
            return #colorLiteral(red: 0.137254902, green: 0.3215686275, blue: 0.4862745098, alpha: 1)
        case .blueColor:
            return #colorLiteral(red: 0, green: 0.6156862745, blue: 0.8745098039, alpha: 1)
        case .charcoalGrayColor:
            return #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        case .orangeColor:
            return #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1)
        case .brownColor:
            return #colorLiteral(red: 0.6941176471, green: 0.3725490196, blue: 0.1843137255, alpha: 1)
        case .meeButtonBg,
             .veryLigthGray:
            return #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        case .meeButtonBorder:
            return #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        case .formFieldPlaceholderActiveColor,
             .formFieldDividerActiveColor,
             .formFieldBorderActiveColor:
            return #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        case .textFieldLabel:
            return #colorLiteral(red: 0, green: 0.3803921569, blue: 0.4784313725, alpha: 1)
        case .buttonTitleNormal:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .buttonDisabled:
            return #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        case .buttonTitleDisabled,
             .formDivider,
             .iconButtonTintSecondary:
            return #colorLiteral(red: 0.6196078431, green: 0.6235294118, blue: 0.6196078431, alpha: 1)
        case .infoIconTint:
            return #colorLiteral(red: 0.6196078431, green: 0.1215686275, blue: 0, alpha: 1)
        case .formFieldPlaceholderNormalColor,
             .formFieldDividerNormalColor,
             .formFieldBorderNormalColor:
            return #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        case .appBackgroundColor:
            return #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 1, alpha: 1)
        case .formFieldTextColor:
            return .black
        default:
            return .lightGray
        }
    }
    
}
