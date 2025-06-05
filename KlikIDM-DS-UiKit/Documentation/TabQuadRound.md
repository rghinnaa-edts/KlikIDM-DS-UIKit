# TabQuadRound
The `TabQuadRound` component is a compact UI element that represents information, attributes, or actions in a small, distinctive visual container that has shape of Quad Round. 

## TabDefault Overview
![TabQuadRound Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1749099513/WhatsApp_GIF_2025-06-05_at_11.53.26_jse8vs.gif)

## Installation
To use the `TabQuadRound` component, please follow this step.
- For current availability, It's available only when you add all the TabQuadRound and TabQuadRoundCell class file of swift and XIB into your project. It placed at `KlikIDM-DS-UiKit/View/Tab/QuadRound`
- Add class TabQuadRound.xib
- Add class TabQuadRound.swift
- Add class TabQuadRoundCell.xib
- Add class TabQuadRoundCell.swift
  
### Usage
- Create a UIView and direct it to custom class TabQuadRound.swift and set the height of it view to 36
```swift
  @IBOutlet var vTabTop: TabQuadRound!
```

- Create a function and set the delegate, and setData()
```swift
    private func setupTabTop() {
        vTabTop.setData(tabItems)
        vTabTop.delegate = self
    }
```

You can see detail implementation at `KlikIDM-DS-UiKit/ViewController/Prototype/PromoGiftPage/PromoGiftViewController.swift`

## Methods
- `setData(_ tabData: [TabQuadRoundModel])`

For further customization or to extend this component, you can ask UX Engineer or Inherit the `TabQuadRound` and override its methods or add additional functionality as required.
