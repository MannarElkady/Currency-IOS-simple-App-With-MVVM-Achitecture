//
//  CollectionViewCell.swift
//  Concurrency
//
//  Created by MagoSpark on 4/24/20.
//  Copyright © 2020 ManarOrg. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var currencyValLabel: UILabel!
    @IBOutlet weak private var currencykeyLabel: UILabel!
    
    var currencyDetails : CurrencyDisplayed? {
        didSet{
            currencykeyLabel.text = currencyDetails?.currency
            currencyValLabel.text = "\(String(describing: (currencyDetails?.value)!))"
        }
    }
    
}
