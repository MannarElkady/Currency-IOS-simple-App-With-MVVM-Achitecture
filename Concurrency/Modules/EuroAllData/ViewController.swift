//
//  ViewController.swift
//  Concurrency
//
//  Created by MagoSpark on 4/24/20.
//  Copyright © 2020 ManarOrg. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController{
    @IBOutlet weak private var searchBox: UISearchBar!
    
    
    @IBOutlet weak private var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    private lazy var viewModel = EuroViewModel(network: NetworkService())
    
    private func setCollectionView(){
        viewModel.currencyDisplayedDriver   .drive(collectionView.rx.items(cellIdentifier: "cell", cellType: CollectionViewCell.self)){ (row,item,cell) in
            cell.currencyDetails = item
        }.disposed(by: disposeBag)
    }
    
    private func filterCurrency(){
        searchBox.rx.text.orEmpty.debounce(.milliseconds(300), scheduler: MainScheduler.asyncInstance).subscribe({
            [weak self] txt in
            guard let self = self else {return}
            if let text = txt.element{
                self.viewModel.filterCurrency(withText: text)
            }
        })
    }
   
    override func viewDidLoad() {
        print(searchBox)
        super.viewDidLoad()
        setCollectionView()
        filterCurrency()
        viewModel.getAllCurrency()
    }


}

