//
//  ArticulosManager.swift
//  niveAPI
//
//  Created by Mac13 on 07/06/22.
//

import Foundation

protocol articuloManagerDelegado{
    func actualizar(articulos: [ArticuloDatos])
}

struct ArticuloManager {
    var delegado: articuloManagerDelegado?
    
    func buscarEstadisticas(){
        let urlString = "https://api.plos.org/search?q=title"
        
        if let url = URL(string: urlString){
            let sesion = URLSession(configuration: .default)
            
            let tarea = sesion.dataTask(with: url) { (datos, respuesta, error) in
                if error != nil{
                    print("error al buscar datos: \(error?.localizedDescription)")
                }//if error
                if let datosSeguros = datos{
                    print("Datos seguros")
                    print(datosSeguros)
                    if let listaArticulos = self.parsearJSON(datosArticulo: datosSeguros){
                        
                        delegado?.actualizar(articulos: listaArticulos)
                    }
                }
            }
            tarea.resume()
        }//if let url
    }//func buscar estadisticas
    
    func parsearJSON(datosArticulo: Data) -> [ArticuloDatos]? {
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados: [ArticuloDatos] = try decodificador.decode([ArticuloDatos].self, from: datosArticulo)
            
            //se crea array de paises
            let articulos: [ArticuloDatos] = datosDecodificados
            return articulos
        }catch{
            print("Error al decodificar JSON: \(error.localizedDescription)")
            return nil
        }
    }//fin parsearJSON
    
}
