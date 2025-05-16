//
//  ChipPromo.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 09/05/25.
//

import UIKit

class ChipPromoCell: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var vMaksItem: UIView!
    @IBOutlet var lblMaksItem: UILabel!
    
    var isEnable: Bool = false
    var bgColor: UIColor = UIColor.grey30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChipPromo()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChipPromo()
    }
    
    private func setupChipPromo() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("ChipPromoCell", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        } else {
            print("Failed to load ChipPromo nib")
        }
        
        setupUI()
    }
    
    private func setupUI() {
        setupBackground(isEnable: isEnable, bgColor: bgColor)
        
        vMaksItem.layer.cornerRadius = 4
        vMaksItem.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func setupBackground(isEnable: Bool, bgColor: UIColor) {
        if isEnable {
            containerView.backgroundColor = bgColor
        } else {
            containerView.backgroundColor = UIColor.grey30
        }
    }
    
}
