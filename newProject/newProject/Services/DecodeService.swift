//
//  DecodeData.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 04.12.2022.
//
import Foundation

struct DecodeService {
    func decodeData<T: Decodable>(data: Data, model: T.Type) -> T? {
        do {
            let result = try JSONDecoder().decode(model, from: data)
            return result
        } catch {
            print(error)
        }
        return nil
    }
}
