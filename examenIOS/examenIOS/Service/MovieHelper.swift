//
//  MovieHelper.swift
//  examenIOS
//
//  Created by pekxel ara on 22/03/21.
//

import Foundation
import UIKit
protocol MoviesDelegate: class {
  
}


class MoviesHelper{
    weak var delegate: MoviesDelegate?
    var window: UIWindow?
    init (delegate: MoviesDelegate){
        self.delegate = delegate
    }
    func getMovies(onCompletion: @escaping(Bool?, NSArray) -> Void){
    print("algo")
       //reate the session object

        let session = URLSession.shared
        let url = URL(string: urlBase + callback + "?api_key=" + apiKey)!

    var request = URLRequest(url: url)


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
       
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]

        //create dataTask using the session object to send data to the server
          
       
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
           
            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
             
                    if(!response.isEmpty){
                    onCompletion(true, response["results"] as! NSArray)
                } else {
                    onCompletion(false, [])
                }
                    
                }
            } catch let error {
                print(error)
            }
        })
        
        task.resume()
   
    }
}
