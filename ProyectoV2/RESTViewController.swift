//
//  RESTViewController.swift
//  ProyectoV2
//
//  Created by BigSur on 7/11/23.
//

import UIKit

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
        //Registrar la celda personalizada
        tablaNoticias.register(UINib(nibName: "CeldaNoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celdaNoticia")
        
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        buscarNoticias()
    }
    func buscarNoticias(){
        	let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-11-06&to=2023-11-06&sortBy=popularity&apiKey=dc03f55f7b544681a582e8f2096354a1"
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
    
        
    }
    


