//
//  DetailsViewController.swift
//  myMusicPlayer
//
//  Created by Gandhi Mena Salas on 20/02/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit
import AVFoundation


class DetailsViewController: UIViewController,AVAudioPlayerDelegate {
    
//************Variables
    
    var indexSound:Int? //el numero de cancino seleccionado.
    var randomSound: Int? // numero random del total de canciones
    
    
    let pauseImage = UIImage(named: "pause2")
    let playImage = UIImage(named: "play2")
    let prevImage = UIImage(named: "prev")
    let nextImage = UIImage(named: "next")
    
    //Arrat de strings
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
        //asignamos las imagenes a los botones
        playButton.setImage(pauseImage, forState: .Normal)
        prevButton.setImage(prevImage, forState: .Normal)
        nextButton.setImage(nextImage, forState: .Normal)
        
        
        anadirRecursosdeCanciones(numeroDeCancion: indexSound!)
        
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
            
            anadirRecursosdeCanciones(numeroDeCancion: indexSound!)
            
            
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
            
            anadirRecursosdeCanciones(numeroDeCancion: indexSound!)
            
            
            
        default: //este es el boton shuffle
            
            prevButton.enabled = true
            
            
            
            playButton.setImage(pauseImage, forState: .Normal)
            
            let random: Int = Int (arc4random_uniform(UInt32(listaCanciones.count)))//random
            randomSound = random
            indexSound = randomSound
            print(random)
            
            anadirRecursosdeCanciones(numeroDeCancion: randomSound!)
            
        }
        
    }
    
    
    func anadirRecursosdeCanciones(numeroDeCancion numeroDeCancion:Int){
        
        let cancionDir = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaCanciones[numeroDeCancion], ofType: "mp3")!)
        let nextImgUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(listaPortadas[numeroDeCancion], ofType: "jpg")!)
        let nextImgData = NSData(contentsOfURL: nextImgUrl)
        do{
            try reproductor = AVAudioPlayer(contentsOfURL: cancionDir)
            reproductor.play()
            portada.image = UIImage(data: nextImgData!)
            titulo.text = listaTitulos[numeroDeCancion]
            autor.text = listaAutores[numeroDeCancion]
        }catch{
            
        }
    
    }
    
    
}
