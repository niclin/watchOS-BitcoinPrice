//
//  InterfaceController.swift
//  BTCPrice WatchKit Extension
//
//  Created by Nic on 2017/11/30.
//  Copyright © 2017年 Nic. All rights reserved.
//

import WatchKit
import Foundation

struct CryptoCurrency: Decodable {
    let name: String
    let price_usd: String
}


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateBitcoinPrice()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - Outlets
    @IBOutlet var bitcoinLabel: WKInterfaceLabel!
    @IBOutlet var ethLabel: WKInterfaceLabel!
    @IBOutlet var refreshButton: WKInterfaceButton!
    
    // MARK: - Interactions
    @IBAction func getPrice() {
        updateBitcoinPrice()
    }
    
    // MARK: - Functions
    
    func updateBitcoinPrice() {
        refreshButton.setTitle("刷新中...")
        refreshButton.setEnabled(false)
        bitcoinLabel.setText("-- USD")
        ethLabel.setText("-- USD")
        
        // Coinmarketcap
        guard let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/?limit=10") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let crypto_currency = try JSONDecoder().decode([CryptoCurrency].self, from: data)
                
                let btc_price = crypto_currency.first { $0.name == "Bitcoin" }?.price_usd ?? "0.00"
                let eth_price = crypto_currency.first { $0.name == "Ethereum" }?.price_usd ?? "0.00"
                
                self.bitcoinLabel.setText("\(btc_price) USD")
                self.ethLabel.setText("\(eth_price) USD")
                self.refreshButton.setTitle("刷新")
                self.refreshButton.setEnabled(true)
                
                //Swift 2/3/ObjC
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
//
//                let crypto_currency = CryptoCurrency(json: json)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}
