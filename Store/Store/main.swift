//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    var name: String { get }
    func priceEach() -> Int
}

class Item {
    let name: String
    private let priceEachValue: Int

    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEachValue = priceEach
    }

    func priceEach() -> Int {
        return priceEachValue
    }
}

class Receipt {
    private var itemsList: [SKU] = []

    func add(item: SKU) {
        itemsList.append(item)
    }

    func items() -> [SKU] {
        return itemsList
    }

    func total() -> Int {
        return itemsList.reduce(0) { $0 + $1.priceEach() }
    }

    func output() -> String {
        var lines: [String] = []
        lines.append("Receipt:")
        for item in itemsList {
            let cents = item.priceEach()
            let dollars = cents / 100
            let remainder = cents % 100
            let priceString = String(format: "$%d.%02d", dollars, remainder)
            lines.append("\(item.name): \(priceString)")
        }
        lines.append("------------------")
        let totalCents = total()
        let totalDollars = totalCents / 100
        let totalRem = totalCents % 100
        let totalString = String(format: "$%d.%02d", totalDollars, totalRem)
        lines.append("TOTAL: \(totalString)")
        return lines.joined(separator: "\n")
    }
}

class Register {
    private var currentReceipt = Receipt()

    func scan(_ sku: SKU) {
        currentReceipt.add(item: sku)
    }

    func subtotal() -> Int {
        return currentReceipt.total()
    }

    func total() -> Receipt {
        let finished = currentReceipt
        currentReceipt = Receipt()
        return finished
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

