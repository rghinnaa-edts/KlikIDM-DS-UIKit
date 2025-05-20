# Promo Gift Card in Cart Page
The `Promo Gift Card` is a view that show and direct to "Tebus Murah dan Promo" page. It has animation behavior from a View to Sticky View.

## Features
- Hide `Sticky View Components` (Promo Gift Card & Coupon Card) when scrolling
- Show `Sticky View Components` when scroll stopped
- Show `Sticky View of Promo Gift Card` when it passed the `View of Promo Gift Card`

## Preview
![Promo Gift Card Preview](https://res.cloudinary.com/dr6cm6n5f/image/upload/c_scale,w_300/v1747678632/PromoGiftCard_ehrx32.gif)

## Methods
- `hideView()`
- `handleScrollStop()`

## Installation
To use the `Promo Gift Card in Cart Page`, please follow the step. 
- Create Sticky Promo Gift Card in your View
- Create Promo Gift Card in your View
- Create Sticky Coupon Card in your View
or you can see full of Example implementation at `KlikIDM-DS-UiKit/ViewController/Prototype/CartPage/CartViewController.swift`

### Usage
```swift

class CartViewController: UIViewController {
    
    @IBOutlet var containerPromoGift: UIView!
    @IBOutlet var containerInsidePromoGift: UIView!
    @IBOutlet var containerStickPromoGift: UIView!
    @IBOutlet var containerInsideStickPromoGift: UIView!
    @IBOutlet var containerCoupon: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var loadingPromoTop: Skeleton!
    @IBOutlet var loadingPromo: Skeleton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        scrollView.delegate = self
        
        setupLoadingView()
        
        containerStickPromoGift.isHidden = true
        setupPromoGiftContainers()
        
        containerCoupon.layer.borderWidth = 1
        containerCoupon.layer.borderColor = UIColor.blue50.cgColor
        
        btnBack.setTitle("", for: .normal)
    }
    
    private func setupPromoGiftContainers() {
        containerStickPromoGift.layer.borderWidth = 1
        containerStickPromoGift.layer.borderColor = UIColor.blue50.cgColor
        containerStickPromoGift.layer.shadowOpacity = 0.15
        containerStickPromoGift.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerStickPromoGift.layer.shadowRadius = 3
        containerInsideStickPromoGift.layer.cornerRadius = 14
        
        containerPromoGift.layer.cornerRadius = 8
        containerInsidePromoGift.layer.cornerRadius = 14
    }
    
    private func setupLoadingView() {
        loadingPromoTop.isHidden = false
        loadingPromo.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in guard let self = self else { return }
            
            loadingPromoTop.isHidden = true
            loadingPromo.isHidden = true
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension CartViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideView()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            handleScrollStop(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleScrollStop(scrollView)
    }
    
    private func hideView() {
        UIView.animate(withDuration: 0.2) {
            self.containerStickPromoGift.transform = CGAffineTransform(translationX: 0, y: -self.containerStickPromoGift.frame.height)
            self.containerCoupon.transform = CGAffineTransform(translationX: 0, y: self.containerCoupon.frame.height)
        }
    }
    
    private func handleScrollStop(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        let promoGiftFrame = containerPromoGift.convert(containerPromoGift.bounds, to: scrollView)
        let transitionOffset = promoGiftFrame.origin.y + promoGiftFrame.height
        
        let resetTransform = CGAffineTransform.identity
        
        if scrollOffset > transitionOffset {
            containerStickPromoGift.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.containerStickPromoGift.transform = resetTransform
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.containerCoupon.transform = resetTransform
        }
    }
}
```

* * *

For further customization or to extend this sticky card promo gift and coupon behavior, you can ask UX Engineer or Inherit the `Promo Gift Card in Cart Page` and override its methods or add additional functionality as required.
