//
//  Chip.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

@objc class Chip: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    weak var delegate: ChipDelegate?
    
    var data: [Any] = []
    var cellReuseIdentifier: String = ""
    var currentlySelectedBucketId: String? = nil
    
    func getItemId(_ item: Any) -> String { return "" }
    func setSelectedState(_ cell: UICollectionViewCell, _ isSelected: Bool) {}
    func configureCell(_ cell: UICollectionViewCell, _ item: Any, _ index: Int) {}
}


class ChipBase<CellType: UICollectionViewCell>: Chip {
    
    var cellClass: AnyClass
    
    override var data: [Any] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func getItemId(_ item: Any) -> String {
        if let getItemId = getItemIdClosure {
            return getItemId(item)
        }
        return ""
    }
    
    override func setSelectedState(_ cell: UICollectionViewCell, _ isSelected: Bool) {
        if let typedCell = cell as? CellType, let setSelectedState = setSelectedStateClosure {
            setSelectedState(typedCell, isSelected)
        }
    }
    
    override func configureCell(_ cell: UICollectionViewCell, _ item: Any, _ index: Int) {
        if let typedCell = cell as? CellType, let configureCell = configureCellClosure {
            configureCell(typedCell, item, index)
        }
    }
    
    var configureCellClosure: ((CellType, Any, Int) -> Void)?
    var getItemIdClosure: ((Any) -> String)?
    var setSelectedStateClosure: ((CellType, Bool) -> Void)?
    
    init(frame: CGRect, cellClass: AnyClass, cellReuseIdentifier: String) {
        self.cellClass = cellClass
        super.init(frame: frame)
        
        self.cellReuseIdentifier = cellReuseIdentifier
        setupChip()
    }
    
    override init(frame: CGRect) {
        self.cellClass = CellType.self
        super.init(frame: frame)
        
        self.cellReuseIdentifier = String(describing: CellType.self)
        setupChip()
    }

    required init?(coder: NSCoder) {
        self.cellClass = CellType.self
        super.init(coder: coder)
        
        self.cellReuseIdentifier = String(describing: CellType.self)
        setupChip()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupChip() {
        if let nib = Bundle.main.loadNibNamed("Chip", owner: self, options: nil),
           let card = nib.first as? UIView {
            containerView = card
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(containerView)
            
            setupUI()
        } else {
            print("Failed to load Chip XIB")
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
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.decelerationRate = .normal
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func selectDefaultChip() {
        guard !data.isEmpty else { return }
        
        let defaultSelectedIndexPath = IndexPath(item: 0, section: 0)
        currentlySelectedBucketId = getItemId(data[0])
        
        if let cell = collectionView.cellForItem(at: defaultSelectedIndexPath) as? CellType {
            for index in 0..<data.count {
                let indexPath = IndexPath(item: index, section: 0)
                if let otherCell = collectionView.cellForItem(at: indexPath) as? CellType {
                    setSelectedState(otherCell, false)
                }
            }
            
            setSelectedState(cell, true)
        }
    }
}

protocol ChipDelegate: AnyObject {
    func didSelectChip(at index: Int, withId id: String)
}

extension Chip: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        let item = data[indexPath.item]
        configureCell(cell, item, indexPath.item)
        
        let isSelected = getItemId(item) == currentlySelectedBucketId
        setSelectedState(cell, isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 90
        let height = 48
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<data.count {
            let deselectIndexPath = IndexPath(item: index, section: 0)
            if let cell = collectionView.cellForItem(at: deselectIndexPath) {
                setSelectedState(cell, false)
            }
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            setSelectedState(cell, true)
        }
        
        let selectedData = getItemId(data[indexPath.item])
        currentlySelectedBucketId = selectedData
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellFrame = flowLayout.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
            
            let contentOffsetX = cellFrame.midX - (collectionView.bounds.width / 2)
            
            let adjustedOffsetX = max(0, min(contentOffsetX,
                                             collectionView.contentSize.width - collectionView.bounds.width))
            
            collectionView.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
        }
        
        if let delegate = (self as? ChipBase<UICollectionViewCell>)?.delegate {
            delegate.didSelectChip(at: indexPath.item, withId: selectedData)
        }
    }
}
