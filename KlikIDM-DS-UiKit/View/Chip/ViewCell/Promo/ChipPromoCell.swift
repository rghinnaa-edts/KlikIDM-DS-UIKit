//
//  ChipPromo.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 09/05/25.
//

import UIKit

class ChipPromoCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var vChip: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var vIndicator: UIView!
    
    var isSelectedState: Bool = false {
        didSet {
            setupBackground(isEnable: isEnable)
        }
    }
    
   private var isEnable: Bool = true
    
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
    
    private func setupBackground(isEnable: Bool) {
        vIndicator.isHidden = !isSelectedState
        
        if isEnable {
            if isSelectedState {
                vChip.backgroundColor = UIColor.blue50
                lblTitle.textColor = UIColor.white
            } else {
                vChip.backgroundColor = UIColor.blue20
                lblTitle.textColor = UIColor.grey50
            }
        } else {
            vChip.backgroundColor = UIColor.grey30
            lblTitle.textColor = UIColor.white
        }
    }
    
    func loadData(data: ChipPromoModel) {
        lblTitle.text = data.title
        isEnable = data.isEnable
        
        setupBackground(isEnable: isEnable)
    }
    
}

extension ChipPromoCell: ChipCellProtocol {
    func loadData(item: ChipModelProtocol) {
        if let customData = item as? ChipPromoModel {
            loadData(data: customData)
        } else {
            let customData = ChipPromoModel(
                id: item.id,
                title: "",
                isEnable: item.isEnable
            )
            loadData(data: customData)
        }
    }
}
