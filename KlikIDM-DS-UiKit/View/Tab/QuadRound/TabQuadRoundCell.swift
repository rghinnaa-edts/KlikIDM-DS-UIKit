//
//  TabPromoCell.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 26/05/25.
//

import UIKit

class TabQuadRoundCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var vChip: UIView!
    @IBOutlet var lblTab: UILabel!
    @IBOutlet var badgeTab: UIView!
    @IBOutlet var lblBadge: UILabel!
    
    var isSelectedState: Bool = false {
        didSet {
            setupBackground()
            invalidateIntrinsicContentSize()
        }
    }
    
   private var isEnable: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabPromo()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabPromo()
    }
    
    private func setupTabPromo() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("TabPromoCell", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        } else {
            print("Failed to load TabPromo nib")
        }
        
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    override var intrinsicContentSize: CGSize {
        let width: CGFloat = isSelectedState ? 120 : 86
        let height: CGFloat = vChip?.frame.height ?? 40
        return CGSize(width: width, height: height)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.size = intrinsicContentSize
        return attributes
    }
    
    private func setupBackground() {
        if isSelectedState {
            vChip.backgroundColor = UIColor.red
            lblTab.textColor = UIColor.blue50
            badgeTab.backgroundColor = UIColor.blue50

            updateChipSize(120)
        } else {
            vChip.backgroundColor = UIColor.blue20
            lblTab.textColor = UIColor.grey50
            badgeTab.backgroundColor = UIColor.grey50
            
            updateChipSize(86)
        }
    }
    
    func loadData(data: TabModel) {
        lblTab.text = data.title
        lblBadge.text = "\(data.total)"
        
        setupBackground()
    }
    
    private func updateChipSize(_ width: CGFloat) {
        var frame = vChip.frame
        frame.size.width = width
        vChip.frame = frame
        
        var containerFrame = containerView.frame
        containerFrame.size.width = width
        containerView.frame = containerFrame
        
        var cellFrame = self.frame
        cellFrame.size.width = width
        self.frame = cellFrame
    }
    
}

extension TabQuadRoundCell: ChipCellProtocol {
    func loadData(item: ChipModelProtocol) {
        if let customData = item as? TabModel {
            loadData(data: customData)
        } else {
            let customData = TabModel(
                id: item.id,
                title: "",
                total: 0
            )
            loadData(data: customData)
        }
    }
}
