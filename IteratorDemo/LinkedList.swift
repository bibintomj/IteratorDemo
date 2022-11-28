//
//  LinkedList.swift
//  IteratorDemo
//
//  Created by Bibin Tom Joseph on 26/11/22.
//

import Foundation

struct LinkedList<Value>: Sequence {
    fileprivate(set) var first: Node?
    fileprivate(set) var last: Node?

    var count = 0

    init(_ values: Value...) {
        values.forEach { self.append(value: $0) }
    }

    func makeIterator() -> AnyIterator<Value> {
        var node = first
        return AnyIterator {
            let value = node?.value
            node = node?.next
            return value
        }
    }

    @discardableResult mutating func append(value: Value) -> Node {
        let node = Node(value: value)
        node.previous = last
        last?.next = node
        last = node
        if first == nil { first = node }
        count += 1
        return node
    }

    @discardableResult mutating func remove(node: Node) -> Node {
        node.previous?.next = node.next
        node.next?.previous = node.previous

        if node === first { first = node.next }
        if node === last { last = node.previous }

        node.disconnect()
        count -= 1
        return node
    }
}

extension LinkedList {
    class Node {
        var value: Value
        fileprivate(set) weak var previous: Node?
        fileprivate(set) var next: Node?

        init(value: Value, previous: Node? = nil, next: Node? = nil) {
            self.value = value
            self.previous = previous
            self.next = next
        }

        func disconnect() {
            next = nil
            previous = nil
        }
    }
}

extension LinkedList.Node: Equatable where Value: Equatable {
    static func == (lhs: LinkedList<Value>.Node, rhs: LinkedList<Value>.Node) -> Bool {
        lhs.value == rhs.value
    }
}

extension LinkedList.Node {
    @discardableResult func printStructure() -> String {
        let string = "[\(String(describing: previous?.value))] - \(value) - [\(String(describing: next?.value))]"
        print(string)
        return string
    }
}
