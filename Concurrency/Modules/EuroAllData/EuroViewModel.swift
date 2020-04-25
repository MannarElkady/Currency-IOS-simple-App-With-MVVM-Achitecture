//
//  EuroProtocols.swift
//  Concurrency
//
//  Created by MagoSpark on 4/24/20.
//  Copyright © 2020 ManarOrg. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EuroViewModelProtocol {
    var currencyDisplayedDriver : Driver<Array<CurrencyDisplayed>> {set get}
    func getAllCurrency()
    func filterCurrency(withText string : String)
}

class EuroViewModel : EuroViewModelProtocol{
    
    var arrayOfCurrencies : Array<CurrencyDisplayed>?
    private lazy var arrayOfConcurrencies = Array<CurrencyDisplayed>()
    
    var currencyDisplayedDriver: Driver<Array<CurrencyDisplayed>>
    
    private let network : NetworkService
    
    private let publishSubject = PublishSubject<Array<CurrencyDisplayed>>()
    
    init(network:NetworkService) {
        self.network = network
        currencyDisplayedDriver = publishSubject.asDriver(onErrorJustReturn: [])
    }
    
    func filterCurrency(withText string: String) {
        let filteredArray = arrayOfConcurrencies.filter({
            currency in return currency.currency.hasPrefix(string)
        })
        if (filteredArray.count > 0){
            publishSubject.onNext(filteredArray)
        }
    }
    
    func getAllCurrency() {
        network.getResponseData(SuccessHandler:{
            [weak self]
            (decodable:Currency) in
            guard let self = self else {return}
            print("Success\(String(describing: decodable.rates["THB"]))")
            decodable.rates.forEach({
                str,double in
                let currency = CurrencyDisplayed(currency: str, value: double)
                //must save the backend list
                self.arrayOfConcurrencies.append(currency)
            })
            self.publishSubject.onNext(self.arrayOfConcurrencies)
        }, ErrorHandler: {
            print("Failed")
        })
    }
    
}
