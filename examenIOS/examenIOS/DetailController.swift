//
//  DetailController.swift
//  examenIOS
//
//  Created by pekxel ara on 23/03/21.
//

import UIKit

class DetailController: UIViewController {
    var imgpath: String = ""
    var moviedesc: String = ""
    var date: String = ""
    var movietitle: String = ""
    var rating: NSNumber = 0
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var peliImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //dateLbl.text = date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterGet.date(from: date) {
           dateLbl.text = "Estreno: \(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
        descLbl.text = moviedesc
        titleLbl.text = movietitle
        let roundedNumber = round(Double(truncating: rating) * 10)/10
        ratingLbl.text = "Rating: \(roundedNumber)"
        setImageToImageView()
        // Do any additional setup after loading the view.
    }
    
    func setImageToImageView() {
        fetchImage(from: imgpath) { (imageData) in
            if let data = imageData {

                DispatchQueue.main.async {
                  
                    self.peliImg.image = UIImage(data: data)
                 
                }
            } else {
                    
                print("Error loading image");
            }
        }
    }
    
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
         let session = URLSession.shared
         let url = URL(string: urlString)
             
         let dataTask = session.dataTask(with: url!) { (data, response, error) in
             if error != nil {
                 print("Error fetching the image! 😢")
                 completionHandler(nil)
             } else {
                 completionHandler(data)
             }
         }
             
         dataTask.resume()
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
