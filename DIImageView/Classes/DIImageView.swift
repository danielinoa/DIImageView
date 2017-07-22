//
//  DIImageView.swift
//  DIImageVIew
//
//  Created by Daniel Inoa on 8/18/14.
//  Copyright © 2016 Daniel Inoa. All rights reserved.
//

import UIKit

open class DIImageView: UIImageView, UITextFieldDelegate {
    
    // MARK: - Lifecycle
    
    public override init(image: UIImage?) {
        super.init(image: image)
        configure()
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        addSubview(caption)
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(panRecognizer)
        isUserInteractionEnabled = true
        captionCenterY = bounds.height/2
    }
    
    // MARK: - Subviews
    
    private lazy var caption: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        textField.textAlignment = .center
        textField.textColor = .white
        textField.tintColor = .white
        textField.keyboardAppearance = .dark
        textField.delegate = self
        return textField
    }()
    
    private var captionCenterY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let captionSize = CGSize(width: bounds.size.width, height: 32)
        caption.bounds = CGRect(origin: CGPoint.zero, size: captionSize)
        let centerX = bounds.width/2
        caption.center = CGPoint(x: centerX, y: captionCenterY)
    }
    
    // MARK: - Gestures
    
    private lazy var tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    private lazy var panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
    
    @objc private func tapped(_ sender: AnyObject) {
        if caption.isFirstResponder {
            caption.resignFirstResponder()
            caption.isHidden = caption.text?.isEmpty ?? true
        } else {
            caption.becomeFirstResponder()
            caption.isHidden = false
        }
    }
    
    @objc private func panned(_ sender: AnyObject) {
        guard let panRecognizer = sender as? UIPanGestureRecognizer else { return }
        let location = panRecognizer.location(in: self)
        captionCenterY = location.y
    }
    
    // MARK: - Text Field Delegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let captionFont = textField.font, textField == caption && !string.isEmpty else { return true }
        let textSize = textField.text?.size(attributes: [NSFontAttributeName: captionFont]) ?? CGSize.zero
        return (textSize.width + 16 < textField.bounds.size.width)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard caption == textField else { return }
        caption.isHidden = caption.text?.isEmpty ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard caption == textField else { return true }
        return caption.resignFirstResponder()
    }
    
}
