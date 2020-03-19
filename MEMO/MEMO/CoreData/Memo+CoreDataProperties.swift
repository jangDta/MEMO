//
//  Memo+CoreDataProperties.swift
//  MEMO
//
//  Created by 장용범 on 2020/03/19.
//  Copyright © 2020 장용범. All rights reserved.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}
