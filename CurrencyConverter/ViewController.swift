//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ömer Tarık Özcura on 5.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    
    @IBOutlet weak var chfLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // request & session
        // response & data
        // parsing & json serialization
        
        
        // http bağlantılara izin vermek için Info içinde App transport security settings ekelenecek bunun içinde allows arbitary load yes yapılacak
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        
        let session = URLSession.shared // singleton object oluşturur
        //Closure
        //completionHandler bir input veriliyor karşısında çıktı alınacak bu çıktı içerisinde
        // data response ve hata bilgisi var completionhandler ile bu bilgiler daha kolay alınıyor
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                //error?.localizedDescription kullanıcının anlayabileceği mesaj gösterimi
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
                
            }else{
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!,options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String:Any]{
                                
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let tr = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY : \(tr)"
                                }
                            }
                        }
                        
                    }catch{
                        print("error")
                    }
                }
            }
        }
        
        task.resume() // taskın çalışması için
        
    }
    
}

