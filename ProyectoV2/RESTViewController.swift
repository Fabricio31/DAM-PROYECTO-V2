//
//  RESTViewController.swift
//  ProyectoV2
//
//  Created by BigSur on 7/11/23.
//

import UIKit
import SafariServices

struct NoticiasModelo:Codable {
    var articles: [Noticia]
}

struct Noticia: Codable{
    let title : String?
    let description: String?
    let url: String?
    let urlToImage: String?
    
}


class RESTViewController: UIViewController {
    
    
    var articuloNoticias:[Noticia] = []

    @IBOutlet weak var tablaNoticias: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Noticias Cibertec"
        //Registrar la celda personalizada
        tablaNoticias.register(UINib(nibName: "CeldaNoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaNoticia")
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        buscarNoticias()
    }
    func buscarNoticias(){
        	let urlString = "https://api.mocki.io/v2/5024f379/api-cibertec/"
        if let url = URL(string: urlString ){
            if let data = try? Data(contentsOf: url){
                let decodificador = JSONDecoder()
                if let datosDecodificados = try? decodificador.decode(NoticiasModelo.self, from: data){
                    //print("datosDecodificados: \(datosDecodificados.articles)")
                    articuloNoticias = datosDecodificados.articles
                    tablaNoticias.reloadData()
                }
            }
        }
    }
}
    
extension RESTViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articuloNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celdaNoticia", for: indexPath) as! CeldaNoticiaTableViewCell
        celda.tituloNoticiaLabel.text = articuloNoticias[indexPath.row].title
        celda.descripcionNoticiaLabel.text = articuloNoticias[indexPath.row].description
        
        if let url = URL(string: articuloNoticias[indexPath.row].urlToImage ?? ""){
            if  let imagenData = try? Data(contentsOf: url){
                celda.imagenNoticiaIV.image = UIImage(data: imagenData)
            }
        }
        
        return celda
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaNoticias.deselectRow(at: indexPath, animated: true)
        guard let urlMostrar = URL(string: articuloNoticias[indexPath.row].url ?? "") else{
            return
        }
        let VCSS = SFSafariViewController(url: urlMostrar)
        present(VCSS, animated: true)
    }
    
    
    
    
    
        
    }
    


