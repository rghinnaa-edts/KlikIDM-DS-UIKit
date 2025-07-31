//
//  Extension.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 20/05/25.
//

import UIKit
import ObjectiveC

extension UIView {
    private static var topLeftCornerRadiusKey = 0
    private static var topRightCornerRadiusKey = 0
    private static var bottomLeftCornerRadiusKey = 0
    private static var bottomRightCornerRadiusKey = 0

    var isTopLeftCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, &Self.topLeftCornerRadiusKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &Self.topLeftCornerRadiusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    var isTopRightCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, &Self.topRightCornerRadiusKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &Self.topRightCornerRadiusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    var isBottomLeftCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, &Self.bottomLeftCornerRadiusKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &Self.bottomLeftCornerRadiusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    var isBottomRightCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, &Self.bottomRightCornerRadiusKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &Self.bottomRightCornerRadiusKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    private func updateCornerMask() {
        var cornerMask = CACornerMask()

        if isTopLeftCornerRounded {
            cornerMask.insert(.layerMinXMinYCorner)
        }

        if isTopRightCornerRounded {
            cornerMask.insert(.layerMaxXMinYCorner)
        }

        if isBottomLeftCornerRounded {
            cornerMask.insert(.layerMinXMaxYCorner)
        }

        if isBottomRightCornerRounded {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }

        self.layer.maskedCorners = cornerMask
    }

    func setRoundedCorners(radius: CGFloat, corners: [UIRectCorner]) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true

        self.isTopLeftCornerRounded = false
        self.isTopRightCornerRounded = false
        self.isBottomLeftCornerRounded = false
        self.isBottomRightCornerRounded = false

        for corner in corners {
            switch corner {
            case .topLeft:
                self.isTopLeftCornerRounded = true
            case .topRight:
                self.isTopRightCornerRounded = true
            case .bottomLeft:
                self.isBottomLeftCornerRounded = true
            case .bottomRight:
                self.isBottomRightCornerRounded = true
            case .allCorners:
                self.isTopLeftCornerRounded = true
                self.isTopRightCornerRounded = true
                self.isBottomLeftCornerRounded = true
                self.isBottomRightCornerRounded = true
            default:
                break
            }
        }
    }
}

