//
//  MovieListController.swift
//  examenIOS
//
//  Created by pekxel ara on 22/03/21.
//

import UIKit

class MovieListController: UITableViewController, MoviesDelegate {
    var moviesHelper:MoviesHelper?
    var pelis: NSArray = []
    var peli: [String:String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesHelper = MoviesHelper(delegate: self)
        print("aver")
        moviesHelper?.getMovies(onCompletion: {(success: Bool?, response: NSArray) in DispatchQueue.main.async { [self] in
            if(success == true){//Todo bien
                // self.botellasArray = response["data"] as! NSMutableArray
               //  self._botellas = self.botellasArray as NSArray

               //  self.bottlesList.reloadData()
                self.pelis = response
                print(pelis[1])
             } else{
                print("error")
             }
         }
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

  
    
     func showError(_ error: String) {
       
    }
    
     func hideError() {
        
    }
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("en teoria solo regreso un numero")
      
        return pelis.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoiveCell
        let peli = pelis[indexPath.row]
        print("relleno")
        print(peli)
        cell.nameLbl.text = "test"
              return cell
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
