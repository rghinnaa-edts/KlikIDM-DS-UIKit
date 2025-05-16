//
//  Untitled.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 15/05/25.
//

import UIKit

class PromoCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    
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
        vChip.layer.cornerRadius = 6
        vIndicator.layer.cornerRadius = 2
    }
    
}
