//
//  LinkRepository.swift
//  ProyectoV2
//
//  Created by BigSur on 4/11/23.
//

import Foundation

final class LinkRepository{
    
    private let linkDataSource: LinkDatasource
    
    init(linkDataSource: LinkDatasource = LinkDatasource()){
        self.linkDataSource = linkDataSource
    }
    
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        linkDataSource.getAllLinks(completionBlock: completionBlock)
    }
    
    
    
}
