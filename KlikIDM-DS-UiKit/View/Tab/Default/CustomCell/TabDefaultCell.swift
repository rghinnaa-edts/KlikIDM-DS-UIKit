//
//  TabDefault.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 16/05/25.
//

import UIKit

class TabDefaultCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var lblTab: UILabel!
    @IBOutlet var vTotal: UIView!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var vIndicator: UIView!
    
    var isSelectedState: Bool = false {
        didSet {
            setupBackground()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTab()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTab()
    }
    
    private func setupTab() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("TabDefaultCell", owner: self, options: nil),
           let view = nib.first as? UIView {
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        } else {
            print("Failed to load TabDefaultCell nib")
        }
        
        setupUI()
    }
    
    private func setupUI() {
        setupBackground()
        
        vTotal.layer.cornerRadius = 8
        vIndicator.layer.cornerRadius = 2
    }
    
    private func setupBackground() {
        vIndicator.isHidden = !isSelectedState
        
        if isSelectedState {
            lblTab.textColor = UIColor.blue50
            vTotal.backgroundColor = UIColor.blue50
        } else {
            lblTab.textColor = UIColor.grey40
            vTotal.backgroundColor = UIColor.grey40
        }
    }
    
    func loadData(_ data: TabQuadRoundModel) {
        lblTab.text = data.title
        lblTotal.text = "\(data.badge)"
    }
}
