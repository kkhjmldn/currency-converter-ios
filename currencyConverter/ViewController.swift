//
//  ViewController.swift
//  urrencyConverter
//
//  Created by kkhjmldn on 06/08/19.
//  Copyright © 2019 kkhjmldn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var fromCurrText: UITextField!
    @IBOutlet weak var toCurrText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var processCaptionLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var fromCurrLabel: UILabel!
    @IBOutlet weak var toCurrLabel: UILabel!
    
    let apiKey = "b6c2f87e3fmsh3fd1085ff2f13f1p1ec16bjsnbc909e30af3a"
    let jsonDecoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let tapFromCurr = UITapGestureRecognizer(target:self,action: #selector(ViewController.loadFromCurrencies(_:)))
        fromCurrLabel.isUserInteractionEnabled = true
        fromCurrLabel.addGestureRecognizer(tapFromCurr)
        
        let tapToCurr = UITapGestureRecognizer(target:self,action: #selector(ViewController.loadToCurrencies(_:)))
        toCurrLabel.isUserInteractionEnabled = true
        toCurrLabel.addGestureRecognizer(tapToCurr)
    }
    
    @IBAction func convert(_ sender: UIButton) {
        
        let from = "USD" //fromCurrLabel.text
        let to = "IDR" //toCurrLabel.text
        guard let amount = valueText.text else  {return}
        //amount = Double(amount)
        
        convertCurrency(from: from, to: to, format: "json", amount: amount)
        
    }
   
    @IBAction func clear(_ sender: UIButton) {
       
        resultLabel.text = "Result"
        fromCurrLabel.text = "Tap to Select Currency"
        toCurrLabel.text = "Tap to Select Currency"
        valueText.text = ""
    }
    
    @IBAction func loadFromCurrencies(_ sender: UITapGestureRecognizer) {
        
        resultLabel.text = "From Curr"
    }
    
    @IBAction func loadToCurrencies(_ sender: UITapGestureRecognizer) {
        
        resultLabel.text = "To Curr"
    }
    
    func convertCurrency(from : String, to: String, format: String, amount:String) {
        processCaptionLabel.text = "Processing ..."
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        //let formattedDate = formatter.string(from: date)
        let formattedDate = "2019-08-16"
        
        let url = "https://currency-converter5.p.rapidapi.com/currency/historical/\(formattedDate)?from=\(from)&to=\(to)&format=\(format)&amount=\(amount)"
        
        let headers = ["Authorization": "Basic \(apiKey)",
            "Content-Type": "application/json",
            "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
            "x-rapidapi-key": apiKey]
        print(url)
        
        Alamofire.request(url, method: .get, parameters: nil, headers:headers).responseJSON {
            response in
            
            if let responseString = response.result.value {
                let jsonResponse = JSON(responseString)
                
                let jsonResultRates = jsonResponse["rates"][to]
                let resultRate = jsonResultRates["rate_for_amount"]
                print("resultRate : \n")
                print(resultRate)
                
                self.resultLabel.text = resultRate.stringValue
            }
            
        }
        processCaptionLabel.text = ""
    }
    
    


}

