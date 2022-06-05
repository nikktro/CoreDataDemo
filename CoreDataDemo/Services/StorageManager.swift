//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Nikolay Trofimov on 02.06.2022.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    private var taskList: [Task] = []
    
    func fetchData(context: NSManagedObjectContext) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            taskList = try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
        }
    }

}
