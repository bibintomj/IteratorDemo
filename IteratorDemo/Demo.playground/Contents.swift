import Foundation


func testCountdown() {
    let countdown = Countdown(startFrom: 10)
    for count in countdown {
        print(count)
    }
}

//testCountdown()

func testLinkedList() {
    var list = LinkedList(1,2,3)
    list.append(value: 4)
    list[2] = 8
    list[4] = 9
    print(list)
    list.remove(at: 3)
    print(list)

}

testLinkedList()
