//
//  ViewController.swift
//  niveAPI
//
//  Created by Mac13 on 07/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var celda: UIView!
    @IBOutlet weak var tablaArticulos: UITableView!
    
    
    
    //Instancia del manager
    var articuloManager = ArticuloManager()
    
    //Arreglo que llena la tabla
    var listaArticulos: [ArticuloDatos] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //Delegados de tabla
        articuloManager.delegado = self
        tablaArticulos.delegate = self //hace ref a ViewController
        tablaArticulos.dataSource = self
        
        articuloManager.buscarEstadisticas()
        
    }//viewdidload
}//viewController

extension ViewController: articuloManagerDelegado {
    func actualizar(articulos: [ArticuloDatos]) {
        print("Total de articulos: \(articulos.count)")
        
        //asigna el array la lista que recibe como parametro
        listaArticulos = articulos
        
        //Actualizar UI desde algo en segundo plano
        DispatchQueue.main.async {
            self.tablaArticulos.reloadData()
        }
    }
}


// MARK: - TABLEVIEW
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaArticulos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaArticulos.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        

        return celda
    }
}//fin extension

