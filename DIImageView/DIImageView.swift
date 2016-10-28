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
        isUserInteractionEnabled = true
        captionCenterY = bounds.height/2
    }
    
    // MARK: - Subviews
    
    private lazy var caption: UITextField = {
        let textField = UITextField()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let captionSize = CGSize(width: bounds.size.width, height: 32)
        caption.bounds = CGRect(origin: CGPoint.zero, size: captionSize)
        caption.center = CGPoint(x: center.x, y: captionCenterY)
    }
    
    // MARK: - Gestures
    
    fileprivate lazy var tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    fileprivate lazy var panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let captionFont = textField.font, textField == caption && !string.isEmpty else { return true }
        let textSize = textField.text?.size(attributes: [NSFontAttributeName: captionFont]) ?? CGSize.zero
        return (textSize.width + 16 < textField.bounds.size.width)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard caption == textField else { return true }
        caption.resignFirstResponder()
        caption.isHidden = caption.text?.isEmpty ?? true
        return caption.resignFirstResponder()
    }
    
}
