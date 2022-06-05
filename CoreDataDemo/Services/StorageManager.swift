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
    
    var taskList: [Task] = []
    
    private let context = AppDelegate().persistentContainer.viewContext
    
    private init() {}
    
    func fetchData() {
        let fetchRequest = Task.fetchRequest()
        
        do {
            taskList = try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
        }
    }
    
    func save(_ taskName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        task.title = taskName
        taskList.append(task)
        saveContextChanges()
    }
    
    func update(indexPath: IndexPath, newText: String) {
        taskList[indexPath.row].title = newText
        saveContextChanges()
    }
    
    func delete(indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        context.delete(task)
        taskList.remove(at: indexPath.row)
        saveContextChanges()
    }
    
    func saveContextChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }

}
