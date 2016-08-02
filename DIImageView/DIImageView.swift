//
//  DIImageView.swift
//  DIImageVIew
//
//  Created by Daniel Inoa on 7/31/16.
//  Copyright © 2016 Daniel Inoa. All rights reserved.
//

import UIKit

class DIImageView: UIImageView, UITextFieldDelegate {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        addSubview(caption)
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(panRecognizer)
        userInteractionEnabled = true
        captionCenterY = bounds.height/2
    }
    
    // MARK: - Subviews
    
    private lazy var caption: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        textField.textAlignment = .Center
        textField.textColor = .whiteColor()
        textField.tintColor = .whiteColor()
        textField.keyboardAppearance = .Dark
        textField.delegate = self
        return textField
    }()
    
    private var captionCenterY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let captionSize = CGSize(width: bounds.size.width, height: 32)
        caption.bounds = CGRect(origin: CGPointZero, size: captionSize)
        caption.center = CGPoint(x: center.x, y: captionCenterY)
    }
    
    // MARK: - Gestures
    
    private lazy var tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    private lazy var panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
    
    func tapped(sender: AnyObject) {
        if caption.isFirstResponder() {
            caption.resignFirstResponder()
            caption.hidden = caption.text?.isEmpty ?? true
        } else {
            caption.becomeFirstResponder()
            caption.hidden = false
        }
    }
    
    func panned(sender: AnyObject) {
        guard let panRecognizer = sender as? UIPanGestureRecognizer else { return }
        let location = panRecognizer.locationInView(self)
        captionCenterY = location.y
    }
    
    // MARK: - Text Field Delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let captionFont = textField.font where textField == caption && !string.isEmpty else { return true }
        let textSize = textField.text?.sizeWithAttributes([NSFontAttributeName: captionFont]) ?? CGSizeZero
        return (textSize.width + 16 < textField.bounds.size.width)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard caption == textField else { return true }
        caption.resignFirstResponder()
        caption.hidden = caption.text?.isEmpty ?? true
        return caption.resignFirstResponder()
    }
    
}
