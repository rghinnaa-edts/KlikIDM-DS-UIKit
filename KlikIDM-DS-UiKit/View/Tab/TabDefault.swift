//
//  Chip.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

class Chip: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!

    weak var delegate: ChipDelegate?
    
    private var cellIdentifier: String = ""
    private var cellType: AnyClass = ChipPromoCell.self
    
    var viewCell: UICollectionViewCell? = nil
    private var _data: [ChipModelProtocol] = []
    var data: [ChipModelProtocol] = [] {
        didSet {
            _data = data
            collectionView.reloadData()
        }
    }
    var currentlySelectedBucketId: String? = nil
    
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    private var itemSpacing: CGFloat = 0
    private var leadingPadding: CGFloat = 16
    private var trailingPadding: CGFloat = 16
    private var topPadding: CGFloat = 0
    private var bottomPadding: CGFloat = 0
    
    private var useDynamicWidth: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChip()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChip()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    private func setupChip() {
        if let nib = Bundle.main.loadNibNamed("TabDefault", owner: self, options: nil),
           let card = nib.first as? UIView {
            containerView = card
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(containerView)
            
            setupUI()
        } else {
            print("Failed to load TabDefault XIB")
        }
    }
    
    private func setupUI() {
        setupChipView()
        
        DispatchQueue.main.async {
            self.selectDefaultChip()
        }
    }
    
    private func setupChipView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: topPadding, left: leadingPadding, bottom: bottomPadding, right: trailingPadding)
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        if useDynamicWidth {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.decelerationRate = .normal
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCellType<T: UICollectionViewCell>(_ cellClass: T.Type, withIdentifier identifier: String) {
        cellType = cellClass
        cellIdentifier = identifier
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func setData<T: ChipModelProtocol>(_ chipData: [T]) {
        self.data = chipData
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    func setItemPadding(topPadding: CGFloat = 0, leadingPadding: CGFloat = 16, bottomPadding: CGFloat = 0, trailingPadding: CGFloat = 16, itemSpacing: CGFloat) {
        self.itemSpacing = itemSpacing
        self.topPadding = topPadding
        self.leadingPadding = leadingPadding
        self.bottomPadding = bottomPadding
        self.trailingPadding = trailingPadding
        
        setupUI()
    }
    
    func selectDefaultChip() {
        guard !data.isEmpty else { return }
                
        let defaultSelectedIndexPath = IndexPath(item: 0, section: 0)
        currentlySelectedBucketId = data[0].id
        
        if let cell = collectionView.cellForItem(at: defaultSelectedIndexPath) as? ChipCellProtocol {
            for index in 0..<data.count {
                let indexPath = IndexPath(item: index, section: 0)
                if let otherCell = collectionView.cellForItem(at: indexPath) as? ChipCellProtocol {
                    otherCell.isSelectedState = false
                }
            }
            
            cell.isSelectedState = true
        }
        
        if useDynamicWidth {
            DispatchQueue.main.async {
                self.collectionView.performBatchUpdates(nil, completion: nil)
            }
        }
    }
    
}

protocol ChipDelegate: AnyObject {
    func didSelectChip(at index: Int, withId id: String)
}

protocol ChipModelProtocol {
    var id: String { get }
}

protocol ChipCellProtocol: UICollectionViewCell {
    func loadData(item: ChipModelProtocol)
    var isSelectedState: Bool { get set }
}

extension Chip: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let chipCell = cell as? ChipCellProtocol {
            let chipData = data[indexPath.item]
            chipCell.loadData(item: chipData)
            chipCell.isSelectedState = (chipData.id == currentlySelectedBucketId)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if useDynamicWidth {
            return CGSize.zero
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<data.count {
            let deselectIndexPath = IndexPath(item: index, section: 0)
            if let cell = collectionView.cellForItem(at: deselectIndexPath) as? ChipCellProtocol {
                cell.isSelectedState = false
            }
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ChipCellProtocol {
            cell.isSelectedState = true
        }
        
        let selectedData = data[indexPath.item].id
        currentlySelectedBucketId = selectedData
        
        if useDynamicWidth {
            UIView.animate(withDuration: 0.3) {
                self.collectionView.performBatchUpdates(nil, completion: nil)
            }
        }
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellFrame = flowLayout.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
            
            let contentOffsetX = cellFrame.midX - (collectionView.bounds.width / 2)
            
            let adjustedOffsetX = max(0, min(contentOffsetX,
                                             collectionView.contentSize.width - collectionView.bounds.width))
            
            collectionView.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
        }
        
        delegate?.didSelectChip(at: indexPath.item, withId: selectedData)
    }
}


