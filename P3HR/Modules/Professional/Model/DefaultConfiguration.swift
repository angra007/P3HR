//
//  DefaultConfiguration.swift
//  P3HR
//
//  Created by Ankit Angra on 03/08/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import EVReflection


class ConfigurationDetails : Root {
    var details : DefaultConfiguration?
}

class DefaultConfiguration : BaseModel {
    var organization  = [Configuration]()
    var helthProfessionals = [Configuration]()
    var departments = [Configuration]()
}

class Configuration : BaseModel  {
    var _id : String?
    var name : String?
}


