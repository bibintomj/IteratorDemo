import Foundation


func testCountdown() {
    let countdown = Countdown(startFrom: 10)
    for count in countdown {
        print(count)
    }
}

//testCountdown()

func testLinkedList() {
    let linkedList = LinkedList(1,2,3)
    for value in linkedList {
        print(value)
    }
}

testLinkedList()
