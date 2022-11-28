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

    mutating func remove(at index: Int) -> Node { remove(node: getNode(at: index)!) }

    subscript(index: Int) -> Value {
        get {
            let node = getNode(at: index)
            assert(node != nil, "No nodes found in the specified range")
            return node!.value
        }
        set {
            guard index != count else {
                append(value: newValue)
                return
            }
            replace(value: newValue, at: index)
        }
    }

    func getNode(at index: Int) -> Node? {
        guard 0 <= index && index < count else {
            assertionFailure("Index out of bounds")
            return nil
        }
        guard index < count && index >= 0 else { return nil }
        guard index != 0 else { return first }
        guard index != count - 1 else { return last }

        var currentNode = first
        (1...index).forEach { _ in
            currentNode = currentNode?.next
        }
        return currentNode
    }

    mutating func insert(value: Value, at index: Int) -> Node {
        assert(0 <= index && index <= count, "Index out of bounds")
        guard index != count else { return append(value: value) }

        let newNode = Node(value: value)
        let existingNode = getNode(at: index)
        newNode.previous = existingNode?.previous
        newNode.next = existingNode
        existingNode?.previous = newNode
        count += 1
        return newNode
    }

    @discardableResult func replace(value: Value, at index: Int) -> Node {
        assert(0 <= index && index < count, "Index out of bounds")

        let existingNode = getNode(at: index)
        existingNode?.value = value
        return existingNode!
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

extension LinkedList: CustomStringConvertible {
    var description: String {
        var string = ""
        var currentNode = first
        (0...count - 1).forEach { _ in
            string = "\(string)\(currentNode!.value),"
            currentNode = currentNode?.next
        }
        return "[\(string.dropLast(1))]"
    }
}
