//
//  ViewController.swift
//  examenIOS
//
//  Created by pekxel ara on 22/03/21.
//

import UIKit

class ViewController: UIViewController, MoviesDelegate, UITableViewDelegate, UITableViewDataSource {
    var moviesHelper:MoviesHelper?
    var photourrl: String = ""
    var indexSel: Int = -1
    var finalurl: String = ""
    var pelis: NSArray = []
    var peli: [String:String] = [:]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return pelis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoiveCell
        let peli = pelis[indexPath.row] as! [String:Any]
        print("relleno")
        print(peli)
        cell.nameLbl.text = peli["title"] as! String
        var fecha = peli["release_date"] as! String
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let date = dateFormatterGet.date(from: fecha) {
            cell.dateLbl.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        
        self.photourrl = peli["poster_path"] as! String
        
        self.finalurl = "https://image.tmdb.org/t/p/w500/\(self.photourrl)"
        print(finalurl)
        func setImageToImageView() {
            fetchImage(from: finalurl) { (imageData) in
                if let data = imageData {

                    DispatchQueue.main.async {
                      
                        cell.peliImg.image = UIImage(data: data)
                     
                    }
                } else {
                        
                    print("Error loading image");
                }
            }
        }
        setImageToImageView()
       
              return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSel = indexPath.row
           tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetail", sender: self)
           
    }
    
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        moviesHelper = MoviesHelper(delegate: self)
        moviesHelper?.getMovies(onCompletion: {(success: Bool?, response: NSArray) in DispatchQueue.main.async { [self] in
            if(success == true){
                self.pelis = response
                tableview.reloadData()
             } else{
                print("error")
             }
         }
        })
        
        // Do any additional setup after loading the view.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showDetail")
        {
            let destination:DetailController = segue.destination as! DetailController
            let peli = pelis[indexSel] as! [String:Any]
            destination.date = peli["release_date"] as! String
            self.photourrl = peli["poster_path"] as! String
            
            self.finalurl = "https://image.tmdb.org/t/p/w500/\(self.photourrl)"
            destination.imgpath = finalurl
            destination.movietitle = peli["title"] as! String
            destination.moviedesc = peli["overview"] as! String
            
            destination.rating = peli["vote_average"] as! NSNumber
        }
        
    }
}

