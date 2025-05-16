//
//  CartViewController.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 13/05/25.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet var containerPromoGift: UIView!
    @IBOutlet var containerInsidePromoGift: UIView!
    @IBOutlet var containerStickPromoGift: UIView!
    @IBOutlet var containerInsideStickPromoGift: UIView!
    @IBOutlet var containerCoupon: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var btnBack: UIButton!
    
    private var stickPromoGiftConstraint: [NSLayoutConstraint] = []
    private var isActivelyScrolling: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        scrollView.delegate = self
        setupViewStickPromoGift()
        setupViewPromoGift()
        setupCoupon()
        
        btnBack.setTitle("", for: .normal)
    }
    
    private func setupViewStickPromoGift() {
        containerStickPromoGift.isHidden = true
        
        containerStickPromoGift.layer.borderWidth = 1
        containerStickPromoGift.layer.borderColor = UIColor.blue50.cgColor
        
        containerStickPromoGift.layer.shadowOpacity = 0.15
        containerStickPromoGift.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        containerStickPromoGift.layer.shadowRadius = 3
        
        containerInsideStickPromoGift.layer.cornerRadius = 14
    }
    
    private func setupViewPromoGift() {
        containerPromoGift.layer.cornerRadius = 8
        containerInsidePromoGift.layer.cornerRadius = 14
    }
    
    private func setupCoupon() {
        containerCoupon.layer.borderWidth = 1
        containerCoupon.layer.borderColor = UIColor.blue50.cgColor
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CartViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isActivelyScrolling = true
        
        let slidePromoGiftTransform = CGAffineTransform(
            translationX: 0,
            y: -self.containerStickPromoGift.frame.height
        )
        
        let slideCouponTransform = CGAffineTransform(
            translationX: 0,
            y: self.containerCoupon.frame.height
        )
        
        UIView.animate(withDuration: 0.2) {
            self.containerStickPromoGift.transform = slidePromoGiftTransform
            self.containerCoupon.transform = slideCouponTransform
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollingHasStopped(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollingHasStopped(scrollView)
    }
    
    private func scrollingHasStopped(_ scrollView: UIScrollView) {
        self.isActivelyScrolling = false
        
        let scrollOffset = scrollView.contentOffset.y
        let promoGiftFrame = containerPromoGift.convert(containerPromoGift.bounds, to: scrollView)
        let transitionOffset: CGFloat = promoGiftFrame.origin.y + promoGiftFrame.height
        
        let finalTransform = CGAffineTransform(
            translationX: 0,
            y: 0
        )
        
        if scrollOffset > transitionOffset {
            containerStickPromoGift.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.containerStickPromoGift.transform = finalTransform
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.containerCoupon.transform = finalTransform
        }
    }
}
