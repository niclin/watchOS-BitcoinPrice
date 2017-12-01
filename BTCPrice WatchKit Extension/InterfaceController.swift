//
//  InterfaceController.swift
//  BTCPrice WatchKit Extension
//
//  Created by Nic on 2017/11/30.
//  Copyright © 2017年 Nic. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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
    
    @IBOutlet var cryptoCurrencyLabel: WKInterfaceLabel!
    
    // MARK: - Interactions
    
    @IBAction func getPrice() {
        fetchPrice()
    }
    
    // MARK: - Function
    
    func fetchPrice(){
        
        // Test use Bitoex exchange
        guard let url = URL(string: "https://poloniex.com/public?command=return24hVolume") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

}
