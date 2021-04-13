//
//  CoreData.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 13.04.2021.
//

import Foundation

/*
 
 1. 2 contexts: main UI context (parent), background API context (child)
 2. All API responses work with background context (entities are created inside of context's thread, and are written to context in the same thread)
 3. Changes are propagated to parent context
 4. UI reads data from parent context only (using fetch controllers or manually)
 
 
 
 
 */
