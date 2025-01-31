//
//  DailyRoutineService.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 8/16/24.
//

import Foundation

import Alamofire

final class DailyRoutineService: BaseService {
    
    static let shared = DailyRoutineService()
    
    private override init() {}
}

// MARK: - Extension

extension DailyRoutineService {
    func getDailyRoutine(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.v2DailyMemberURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     NewDailyRoutineEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func patchRoutineAPI(
        routineId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.patchRoutineURL + "\(routineId)"
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let dataRequest = AF.request(url,
                                         method: .patch,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         PatchRoutineEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func deleteRoutineListAPI(routineIdList: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.dailyMemberURL + "?routines=\(routineIdList)"
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .delete,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     NewDailyRoutineEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getChallengeRoutine(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.v2ChallengeURL
        let header: HTTPHeaders = NetworkConstant.hasTokenHeader
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     ChallengeRoutine.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
