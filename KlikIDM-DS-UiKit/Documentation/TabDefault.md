# TabDefault
The `TabDefault` component is a compact UI element that represents information, attributes, or actions in a small, distinctive visual container. 

## Features
- Customizable View Cell (UICollectionViewCell)
- Customizable Data Model (Struct)

## TabDefault Overview
![TabDefault Preview](
https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1749099394/WhatsApp_GIF_2025-06-05_at_11.52.52_kg7l1f.gif)

## Installation
To use the `TabDefault` component, please follow this step.
- For current availability, It's available only when you add all the TabDefault class file of swift and XIB into your project. It placed at `KlikIDM-DS-UiKit/View/Tab/Default`
- Create class of View Cell (UICollectionViewCell) to implement UI of TabDefault items with extended protocol "TabDefaultCellProtocol"
- Create class of Data Model (struct) to define TabDefault model with extended protocol "TabDefaultModelProtocol"

### Usage
- Create a UIView and direct it to custom class TabDefault.swift and set the height of it view (example: 30)
```swift
  @IBOutlet var vTab: TabDefault!
```

- Create a function and set the delegate, registerCellType(), setData(), setDefaultChip(), and you can set the width as Dynamic or Static.
```swift
private func setupChip() {
    vTab.delegate = self
        
    vTab.registerCellType(ChipPromoCell.self, withIdentifier: "ChipPromoCell")
    vTab.setData(getCurrentContentItems().map { $0.chip })

    // if you're using dynamic width 
    vTab.enableDynamicWidth()

    // if you're using static width and height
    vTab.disableDynamicWidth()
    vTab.setSize(width: 100, height: 30)

    vTab.selectDefaultChip()
}
```

====EXAMPLE OF "Tebus Murah dan Promo" Page====

- for Promo Fair Page Tab Level 2, you can use "TabDefaultCell.xib", "TabDefaultCell.swift" and "TabDefaultModel.swift".

- Create TabDefaultModel.swift
```swift
struct TabDefaultModel: TabDefaultModelProtocol {
    var id: String
    var title: String
    var isEnable: Bool
}
```

- Create TabDefaultCell.swift
```swift
class TabDefaultCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var lblTab: UILabel!
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
        
        vIndicator.layer.cornerRadius = 2
    }
    
    private func setupBackground() {
        vIndicator.isHidden = !isSelectedState
        
        if isSelectedState {
            lblTab.textColor = UIColor.blue50
        } else {
            lblTab.textColor = UIColor.grey40
        }
    }
    
    func loadData(_ data: TabDefaultModel) {
        lblTab.text = data.title
    }
}

// add extended protocol with ChipCellProtocol to load data
extension TabDefaultCell: TabDefaultCellProtocol {
    func loadData(item: TabDefaultModelProtocol) {
        if let data = item as? TabDefaultModel {
            loadData(data)
        } else {
            let data = TabDefaultModel(
                id: item.id,
                title: ""
            )
            loadData(data)
        }
    }
}
```

You can see detail implementation at `KlikIDM-DS-UiKit/ViewController/Prototype/PromoGiftPage/PromoGiftViewController.swift`

## Methods
- `registerCellType<T: UICollectionViewCell>(_ cellClass: T.Type, withIdentifier identifier: String)`
- `setData<T: ChipModelProtocol>(_ chipData: [T])`
- `setDefaultChip()`
- `enableDynamicWidth()`
- `disableDynamicWidth()`
- `setSize()`
- `setItemPadding()`

For further customization or to extend this component, you can ask UX Engineer or Inherit the `TabDefault` and override its methods or add additional functionality as required.
