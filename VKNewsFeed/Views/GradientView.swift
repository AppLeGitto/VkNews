//
//  GradientView.swift
//  VKNewsFeed
//
//  Created by Марк Кобяков on 09.06.2022.
//

import UIKit

class GradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .systemGray
    }
}
