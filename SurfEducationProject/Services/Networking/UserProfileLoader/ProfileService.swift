//
//  ProfileService.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import Foundation

class ProfileService {
    
//MARK: - Properties
    
    static let shared = ProfileService()
    
    var userProfileModel: UserModel?
    var userDefaults = UserDefaults.standard
    
//MARK: - Methods
    func getUserDataModel(from result: AuthResponseModel){
        guard let id = result.user_info["id"],
              let phone = result.user_info["phone"],
              let email = result.user_info["email"],
              let firstName = result.user_info["firstName"],
              let lastName = result.user_info["lastName"],
              let avatar = result.user_info["avatar"],
              let city = result.user_info["city"],
              let about = result.user_info["about"] else { return}
        
        userProfileModel = UserModel(id: id,
                          phone: phone,
                          email: email,
                          firstName: firstName,
                          lastName: lastName,
                          avatar: avatar,
                          city: city,
                          about: about)
        if let model = userProfileModel {
            saveToUserDefailts(model: model)
        }
    }
    
    func getUserDataFromUserDefaults() {
        guard let data = userDefaults.value(forKey: "userData") else { return }
        do {
            let model = try JSONDecoder().decode(UserModel.self, from: data as! Data)
            self.userProfileModel = model
        } catch {
            print(error)
        }
    }
    
    private func saveToUserDefailts(model:UserModel){
        do {
            let data = try JSONEncoder().encode(model)
            userDefaults.set(data, forKey: "userData")
        } catch {
            print(error)
        }
            
    }
}
