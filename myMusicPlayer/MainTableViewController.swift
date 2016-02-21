//
//  MainTableViewController.swift
//  My_beginner_Spotify
//
//  Created by Gandhi Mena Salas on 09/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation


class MainTableViewController: UITableViewController {
    
    
    
    //*****************Variables
    var cancionSeleccionada: Int = 0
    var portadaIndice:NSData!
    
    var DVC = DetailsViewController()
    var miListaTitulos:[String] = [String]()
    var miListaPortadas:[String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        miListaTitulos = DVC.listaTitulos
        miListaPortadas = DVC.listaPortadas
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return miListaTitulos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        cell.textLabel?.text = self.miListaTitulos[indexPath.row]
        
        let imgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(miListaPortadas[indexPath.row], ofType: "jpg")!)
        let imgData = NSData(contentsOfURL: imgUrl)
        
        cell.imageView?.contentMode = UIViewContentMode.ScaleToFill
        cell.imageView?.image = UIImage(data: imgData!)
        cell.imageView?.layer.borderColor = UIColor(colorLiteralRed: 225, green: 225, blue: 225, alpha: 7.0).CGColor
        cell.imageView?.layer.borderWidth = 2
        
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelecRowAtIndexPath indexPath: NSIndexPath){
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        cancionSeleccionada = indexPath.row
        
        self.performSegueWithIdentifier("details", sender: cancionSeleccionada)
        
        
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let DetailsView: DetailsViewController = segue.destinationViewController as! DetailsViewController
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        DetailsView.indexSound = indexPath?.row
        
        
        
    }
    
    
    
}
