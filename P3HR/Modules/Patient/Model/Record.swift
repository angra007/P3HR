//
//  Record.swift
//  P3HR
//
//  Created by Ankit Angra on 13/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class Records : Root {
    var records = [Record] ()
}

class Record: BaseModel {
    var name : String?
    var desc : String?
    var path : String?
}

class Attachment : Root {
    var path : String?
}
