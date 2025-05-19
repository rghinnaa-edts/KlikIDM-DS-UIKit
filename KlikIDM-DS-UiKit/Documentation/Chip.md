# Chip
The `Chip` component is a compact UI element that represents information, attributes, or actions in a small, distinctive visual container. 

## Features
- Customizable View Cell (UICollectionViewCell)
- Customizable Data Model (Struct)

## Chip Overview
![Chip Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1747676404/PromoGiftPage_g0wzxt.gif)

## Installation
To use the `Chip` component, please follow this step.
- For current availability, It's available only when you add all the Chip class file of swift and XIB into your project. It placed at `KlikIDM-DS-UiKit/View/Chip`
- Create class of View Cell (UICollectionViewCell) to implement UI of chip items with extended protocol "ChipCellProtocol"
- Create class of Data Model (struct) to define chip model with extended protocol "ChipModelProtocol"

### Usage
- Create a UIView and direct it to custom class Chip.swift
```swift
  @IBOutlet var vChip: Chip!
```

- Create a function and set the delegate, registerCellType(), setData(), and setDefaultChip()
```swift
private func setupChip() {
    vChip.delegate = self
        
    vChip.registerCellType(ChipPromoCell.self, withIdentifier: "ChipPromoCell")
    vChip.setData(getCurrentContentItems().map { $0.chip })
    vChip.selectDefaultChip()
}
```

====EXAMPLE OF "Tebus Murah dan Promo" Page====

- Create ChipPromoCell.swift
```swift
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


// add extended protocol with ChipCellProtocol to load data
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
```

- Create ChipPromoModel.swift
```swift
struct ChipPromoModel: ChipModelProtocol {
    var id: String
    var title: String
    var isEnable: Bool
}
```

You can see detail implementation at `KlikIDM-DS-UiKit/ViewController/Prototype/PromoGiftPage/PromoGiftPage.swift`

## Methods
`registerCellType<T: UICollectionViewCell>(_ cellClass: T.Type, withIdentifier identifier: String)`
`setData<T: ChipModelProtocol>(_ chipData: [T])`
`setDefaultChip()`

For further customization or to extend this component, you can ask UX Engineer or Inherit the `Chip` and override its methods or add additional functionality as required.
