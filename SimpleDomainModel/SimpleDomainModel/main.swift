//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    var after : Money = Money(amount: self.amount, currency: to)
    if(self.currency == "USD" && to == "GBP") {
      after.amount = Int(Double(self.amount) / 2)
    }
    else if(self.currency == "USD" && to == "EUR") {
      after.amount = Int(Double(self.amount) * 1.5)
    }
    else if(self.currency == "USD" && to == "CAN") {
      after.amount = Int(Double(self.amount) * 1.25)
    }
    else if(self.currency == "GBP" && to == "USD") {
      after.amount = Int(Double(self.amount) * 2.0)
    }
    else if(self.currency == "GBP" && to == "EUR") {
      after.amount = Int(Double(self.amount) * 3.0)
    }
    else if(self.currency == "GBP" && to == "CAN") {
      after.amount = Int(Double(self.amount) * 2.5)
    }
    else if(self.currency == "CAN" && to == "USD") {
      after.amount = Int(Double(self.amount) * 0.8)
    }
    else if(self.currency == "CAN" && to == "EUR") {
      after.amount = Int(Double(self.amount) * 1.2)
    }
    else if(self.currency == "CAN" && to == "GBP") {
      after.amount = Int(Double(self.amount) * 0.4)
    }
    else if(self.currency == "EUR" && to == "USD") {
      after.amount = Int(Double(self.amount) * (2.0 / 3.0))
    }
    else if(self.currency == "EUR" && to == "GBP") {
      after.amount = Int(Double(self.amount) / 3.0)
    }
    else if(self.currency == "EUR" && to == "CAN") {
      after.amount = Int(Double(self.amount) * (5.0 / 6.0))
    }
    return after
  }
  
  public func add(_ to: Money) -> Money {
    let newCurr : Money = self.convert(to.currency)
    return Money(amount : newCurr.amount + to.amount, currency : to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    let newCurr : Money = self.convert(from.currency)
    return Money(amount : newCurr.amount - from.amount, currency : from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType
  
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type{
      case .Hourly(let hourly):
        return Int(Double(hours) * hourly)
      case .Salary(let year):
        return year
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type{
      case .Hourly(let hourly):
        self.type = JobType.Hourly(hourly + amt)
      case .Salary(let year):
        self.type = JobType.Salary(year + Int(amt))
    }
  }
}


////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0
  
  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job }
    set(value) {
      if(self.age >= 16){
        _job = value
      } else {
        _job = nil
      }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
      if(self.age >= 18){
        _spouse = value
      } else {
        _spouse = nil
      }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(45) job:\(self.job) spouse:\(self.spouse)]"
  }
}
//
//////////////////////////////////////
//// Family
////
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if(spouse1.spouse == nil && spouse2.spouse == nil && spouse1.age >= 18 && spouse2.age >= 18){
      spouse1.spouse = spouse2
      spouse2.spouse = spouse1
      members.append(spouse1)
      members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    if(self.members[0].age > 21 || self.members[1].age > 21){
      members.append(child)
      return true
    } else {
      return false
    }
  }
  
  open func householdIncome() -> Int {
    var income : Int = 0
    for person in members {
      if(person.job != nil) {
        income += person.job?.calculateIncome(2000) ?? 0
      }
    }
    return income
  }
}





