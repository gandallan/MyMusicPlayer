//
//  DetailsViewController.swift
//  My_beginner_Spotify
//
//  Created by Gandhi Mena Salas on 09/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer //para el volumen

class DetailsViewController: UIViewController,AVAudioPlayerDelegate {
    
    //************Variables
    
    var indexSound:Int? //el numero de cancino seleccionado.
    var randomSound: Int? //
    var volumenView = MPVolumeView()
    
    let pauseImage = UIImage(named: "pause2")
    let playImage = UIImage(named: "play2")
    let prevImage = UIImage(named: "prev")
    let nextImage = UIImage(named: "next")
    
    //variables para el shuffle
    let listaTitulos: [String] = ["Bajo Short","Baroque Coffee House","Leslie's Struct","Far Away","Cartoon Bank","TimedOut"]
    let listaAutores: [String] = ["AudioNautix","Doug Maxwell","Jhon Deley","MK2","Doug Maxwell","Jingle Punk"]
    let listaPortadas: [String] = ["image1","image2","image3","image4","image5","image6",]
    var listaCanciones: [String] =  ["sound1", "sound2", "sound3", "sound4", "sound5", "sound6"]
    
    //Declaración de AVAudioPlayer
    var reproductor = AVAudioPlayer()
    
    
    
    //*************Outlets
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var volumen: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //************ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* //Volumen del dispositivo
        let wrapperView = UIView(frame: CGRectMake(45, 510, 230, 20))
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(wrapperView)
        let volumenView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumenView)
        */
        
        
        print(indexSound!)
        
        if indexSound == 0 {
            
            prevButton.enabled = false
        }
        
        playButton.setImage(pauseImage, forState: .Normal)
        prevButton.setImage(prevImage, forState: .Normal)
        nextButton.setImage(nextImage, forState: .Normal)
        
        
        //Asignacion de titulo y autor seleccionados de la playlista
        titulo.text = listaTitulos[indexSound!]
        autor.text = listaAutores[indexSound!]
        
        // url de portada, audio seleccionados de la playlist
        let imgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaPortadas[indexSound!], ofType: "jpg")!)
        let imgData = NSData(contentsOfURL: imgUrl) //convrtiendo en data la imagen
        
        let cancionDir = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[indexSound!], ofType: "mp3")!)
        
        
        
        
        do{
            
            
            try reproductor = AVAudioPlayer(contentsOfURL: cancionDir)
            reproductor.play()
            
            portada.image = UIImage(data: imgData!)
            
            
        }catch{
            
        }
        
    }
    
    //**********Volumen con slider
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        let selectedValue = Float(sender.value)
        
        if reproductor.playing{
            
            reproductor.volume = selectedValue
        }
    }
    
    //***********Botones de reproducción
    @IBAction func reproducirMusica(sender: UIButton) {
        
        let botones:String = (sender.titleLabel?.text)!
        
        
        switch botones {
            
        case "play":
            
            if !reproductor.playing{
                
                reproductor.play()
                
                playButton.setImage(pauseImage, forState: .Normal)
                
                
            }else if reproductor.playing{
                
                reproductor.pause()
                playButton.setImage(playImage, forState: .Normal)
                
            }
        case "prev":
            
            playButton.setImage(pauseImage, forState: .Normal)
            
            if indexSound == 0 {
                indexSound! = 6
            }
            
            indexSound!--
            print(indexSound!)
            
            let cancionDir = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[indexSound!], ofType: "mp3")!)
            let nextImgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaPortadas[indexSound!], ofType: "jpg")!)
            let nextImgData = NSData(contentsOfURL: nextImgUrl)
            do{
                try reproductor = AVAudioPlayer(contentsOfURL: cancionDir)
                reproductor.play()
                portada.image = UIImage(data: nextImgData!)
                titulo.text = listaTitulos[indexSound!]
                autor.text = listaAutores[indexSound!]
            }catch{
                
            }
            
            
        case "next":
            
            playButton.setImage(pauseImage, forState: .Normal)
            
            prevButton.enabled = true
            
            if indexSound == 0{
                indexSound! = 0
            }
            if indexSound == 5{
                indexSound! = 0 - 1
            }
            
            indexSound!++
            print(indexSound!)
            
            let cancionDir = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[indexSound!], ofType: "mp3")!)
            let nextImgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaPortadas[indexSound!], ofType: "jpg")!)
            let nextImgData = NSData(contentsOfURL: nextImgUrl)
            do{
                try reproductor = AVAudioPlayer(contentsOfURL: cancionDir)
                reproductor.play()
                portada.image = UIImage(data: nextImgData!)
                titulo.text = listaTitulos[indexSound!]
                autor.text = listaAutores[indexSound!]
            }catch{
                
            }
            
            
        default: //este es el boton shuffle
            
            prevButton.enabled = true
            
            
            
            playButton.setImage(pauseImage, forState: .Normal)
            
            let random: Int = Int (arc4random_uniform(UInt32(listaCanciones.count)))//random
            randomSound = random
            indexSound = randomSound
            print(random)
            
            // url de audio y portada random
            
            let shuffleAudioUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[randomSound!], ofType: "mp3")!)
            let shuffleImgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaPortadas[randomSound!], ofType: "jpg")!)
            let shufflaImgData = NSData(contentsOfURL: shuffleImgUrl)
            
            
            do{
                //si se presiona shuffle tanto play como shuffle obtienen el mismo valor del random
                //try shuffle = AVAudioPlayer(contentsOfURL: shuffleAudioUrl)
                
                try reproductor = AVAudioPlayer(contentsOfURL: shuffleAudioUrl)
                reproductor.play()
                portada.image = UIImage(data: shufflaImgData!)
                
                //obtienen el mismo valor del random
                titulo.text = listaTitulos[randomSound!]
                autor.text = listaAutores[randomSound!]
                
            }catch{
                
            }
            
            
        }
        
    }
    
    
}
