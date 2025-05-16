//
//  StampBrandProduct.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

class StampBrandProduct: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStampBrandProduct()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStampBrandProduct()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupStampBrandProduct() {
        if let nib = Bundle.main.loadNibNamed("StampBrandProduct", owner: self, options: nil),
           let card = nib.first as? UIView {
            containerView = card
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(containerView)
            
            setupUI()
        } else {
            print("Failed to load StampBrandProduct XIB")
        }
    }
    
    private func setupUI() {
    }
    
    private func setupProductView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let cellWidth: CGFloat = 125
        let cellHeight: CGFloat = 180
        
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = UIColor.Support.primaryHighlightWeak
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.decelerationRate = .normal
        collectionView.register(StampCardSmall.self, forCellWithReuseIdentifier: "StampCardSmall")
        
        let totalHeight = cellHeight + flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
            
        collectionView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension StampBrandProduct: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
