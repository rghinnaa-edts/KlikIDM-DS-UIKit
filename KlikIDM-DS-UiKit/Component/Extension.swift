//
//  Extension.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 20/05/25.
//

import UIKit
import ObjectiveC

extension UIView {
    private struct AssociatedKeys {
        static let topLeftCornerRadius = UnsafeRawPointer(bitPattern: "topLeftCornerRadius".hashValue)!
        static let topRightCornerRadius = UnsafeRawPointer(bitPattern: "topRightCornerRadius".hashValue)!
        static let bottomLeftCornerRadius = UnsafeRawPointer(bitPattern: "bottomLeftCornerRadius".hashValue)!
        static let bottomRightCornerRadius = UnsafeRawPointer(bitPattern: "bottomRightCornerRadius".hashValue)!
    }

    var isTopLeftCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, AssociatedKeys.topLeftCornerRadius) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.topLeftCornerRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    var isTopRightCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, AssociatedKeys.topRightCornerRadius) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.topRightCornerRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    var isBottomLeftCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, AssociatedKeys.bottomLeftCornerRadius) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.bottomLeftCornerRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateCornerMask()
        }
    }

    var isBottomRightCornerRounded: Bool {
        get {
            return (objc_getAssociatedObject(self, AssociatedKeys.bottomRightCornerRadius) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, AssociatedKeys.bottomRightCornerRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
