//
//  APIClientUseCase.swift
//  UIKit-Combine-Marvel
//
//  Created by Salva Moreno on 5/11/23.
//

import Foundation

protocol APIClientUseCaseProtocol {
    var repository: APIClientRepositoryProtocol { get set }
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character
}

final class APIClientUseCase: APIClientUseCaseProtocol {
    var repository: APIClientRepositoryProtocol
    
    init(repository: APIClientRepositoryProtocol = APIClientRepository()) {
        self.repository = repository
    }
    
    func getCharacter(by characterName: String, apiRouter: APIRouter) async throws -> Character {
        try await repository.getCharacter(by: characterName, apiRouter: .getCharacter)
    }
}

//esta clase nos vale para diseño de UI de UIKIt y SwiftUI y Testing.
//final class CaseUseBootCampFakeSuccess: caseUseBootcampProtocol{
//    var repository : BootCampsRepositoryProtocol
//    
//    init(repository: BootCampsRepositoryProtocol = BootCampsRepository(network: NetworkBootCampsFakeSuccess())){
//        self.repository = repository
//    }
//    
//    
//    func loadBootcamps(succes: @escaping sucesssClosure, onError:  @escaping errorClosure) -> Void{
//       
//        repository.loadBootcamps(succes: succes, onError: onError)
//       
//    }
//}


//parar Testing, prueba del error
//final class CaseUseBootCampFakeError: caseUseBootcampProtocol{
//
//    var repository : BootCampsRepositoryProtocol
//
//    init(repository: BootCampsRepositoryProtocol = BootCampsRepository(network: NetworkBootCampsFakeError())){
//        self.repository = repository
//    }
//
//    func loadBootcamps(succes: @escaping sucesssClosure, onError: @escaping errorClosure) -> Void{
//        repository.loadBootcamps(succes: succes, onError: onError)
//    }
//}
