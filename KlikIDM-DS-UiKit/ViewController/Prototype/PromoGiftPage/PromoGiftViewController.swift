//
//  PromoGiftViewController.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 09/05/25.
//

import UIKit

class PromoGiftViewController: UIViewController {
    
    @IBOutlet var vChip: Chip!
    @IBOutlet var vATC: UIView!
    @IBOutlet var btnATC: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var collectionTab: UICollectionView!
    @IBOutlet var collectionContentChip: UICollectionView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var selectedTabIndex = 0
    var tabItems: [TabModel] = []
    var items1: [PromoGiftModel] = []
    var items2: [PromoGiftModel] = []
    var isSyncingCollectionView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        setupATC()
        setupChip()
        setupContentChip()
        setupCollectionTab()
        
        loadingIndicator.isHidden = true
        
        btnBack.setTitle("", for: .normal)
    }
    
    private func setupChip() {
        vChip.layer.shadowOpacity = 0.15
        vChip.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        vChip.layer.shadowRadius = 3
        
        vChip.data = getCurrentContentItems().map { $0.chip }
        
        vChip.delegate = self
    }
    
    private func setupATC() {
        vATC.layer.shadowOpacity = 0.15
        vATC.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        vATC.layer.shadowRadius = 3
        
        btnATC.layer.cornerRadius = 4
    }
    
    func setupCollectionTab() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionTab.collectionViewLayout = flowLayout
        collectionTab.backgroundColor = .clear
        collectionTab.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionTab.showsHorizontalScrollIndicator = false
        collectionTab.alwaysBounceHorizontal = true
        collectionTab.decelerationRate = .normal
        collectionTab.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
        
        collectionTab.delegate = self
        collectionTab.dataSource = self
    }
    
    private func setupContentChip() {
        collectionContentChip.delegate = self
        collectionContentChip.dataSource = self
        
        let nib = UINib(nibName: "PromoContentCell", bundle: nil)
        collectionContentChip.register(nib, forCellWithReuseIdentifier: PromoContentCell.identifier)
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionContentChip.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    private func updateChipSelection() {
        vChip.data = getCurrentContentItems().map { $0.chip }
        vChip.selectDefaultChip()
    }
    
    private func getCurrentContentItems() -> [PromoGiftModel] {
        return selectedTabIndex == 0 ? items1 : items2
    }
    
    private func showLoadingState() {
        vChip.isHidden = true
        collectionContentChip.isHidden = true
        loadingIndicator.isHidden = false
        
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingState() {
        loadingIndicator.stopAnimating()
        
        loadingIndicator.isHidden = true
        vChip.isHidden = false
        collectionContentChip.isHidden = false
    }
    
    private func loadData() {
        tabItems = [
            TabModel(title: "Hadiah Produk", total: 3),
            TabModel(title: "Tebus Murah", total: 1),
        ]
        
        items1 = [
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "1",
                    title: "Paragon Fair",
                    isEnable: true),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "2",
                    title: "Live Shopping Semriwings",
                    isEnable: true),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "3",
                    title: "Toples Kaca Idaman Fair",
                    isEnable: true),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "4",
                    title: "Teh Pucuk Fair",
                    isEnable: false),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: false,
                    products: [])),
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "4",
                    title: "Teh Pucuk Fair",
                    isEnable: false),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: false,
                    products: []))
        ]
        
        items2 = [
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "1",
                    title: "Toples Kaca Idaman Fair",
                    isEnable: true),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: ChipPromoModel(
                    id: "2",
                    title: "Alat Makan Fair",
                    isEnable: false),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: false,
                    products: []))
        ]
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension PromoGiftViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionTab {
            return tabItems.count
        } else {
            if selectedTabIndex == 0 {
                return items1.count
            } else {
                return items2.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionTab {
            let cell = collectionTab.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCell
            
            let data = tabItems[indexPath.item]
            cell.loadData(data)
            
            cell.isSelectedState = (indexPath.item == selectedTabIndex)
            
            return cell
        } else {
            let cell = collectionContentChip.dequeueReusableCell(withReuseIdentifier: PromoContentCell.identifier, for: indexPath) as! PromoContentCell
            
            let contentItem = getCurrentContentItems().map { $0.content }
            
            cell.setup(contentItem[indexPath.item])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionTab {
            for index in 0..<tabItems.count {
                let deselectIndexPath = IndexPath(item: index, section: 0)
                if let cell = collectionTab.cellForItem(at: deselectIndexPath) as? TabCell {
                    cell.isSelectedState = false
                }
            }
            
            if let cell = collectionTab.cellForItem(at: indexPath) as? TabCell {
                cell.isSelectedState = true
            }
            
            selectedTabIndex = indexPath.item
            
            showLoadingState()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in guard let self = self else { return }
                
                updateChipSelection()
                collectionContentChip.reloadData()
                
                let firstItemPath = IndexPath(item: 0, section: 0)
                if !getCurrentContentItems().isEmpty {
                    collectionContentChip.scrollToItem(at: firstItemPath, at: .centeredHorizontally, animated: false)
                }
                
                self.hideLoadingState()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionTab {
            return CGSize(width: 105, height: collectionTab.frame.height)
        } else {
            return CGSize(width: collectionContentChip.frame.width, height: collectionContentChip.frame.height)
        }
    }
    
}

extension PromoGiftViewController: ChipDelegate {
    func didSelectChip(at index: Int, withId id: String) {
        guard !isSyncingCollectionView, index < getCurrentContentItems().count else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionContentChip.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
