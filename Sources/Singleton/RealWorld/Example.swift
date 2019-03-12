import XCTest

/// Singleton Design Pattern
///
/// Intent: Ensure that class has a single instance, and provide a global point
/// of access to it.

class SingletonRealWorld: XCTestCase {

    func testSingletonRealWorld() {

        /// There are two view controllers.
        ///
        /// MessagesListVC displays a list of last messages from a user's chats.
        /// ChatVC displays a chat with a friend.
        ///
        /// FriendsChatService fetches messages from a server and provides all
        /// subscribers (view controllers in our example) with new and removed
        /// messages.
        ///
        /// FriendsChatService is used by both view controllers. It can be
        /// implemented as an instance of a class as well as a global variable.
        ///
        /// In this example, it is important to have only one instance that
        /// performs resource-intensive work.

        let listVC = MessagesListVC()
        let chatVC = ChatVC()

        listVC.startReceiveMessages()
        chatVC.startReceiveMessages()

        /// ... add view controllers to the navigation stack ...
    }
}


class BaseVC: UIViewController, MessageSubscriber {

    func accept(new messages: [Message]) {
        /// handle new messages in the base class
    }

    func accept(removed messages: [Message]) {
        /// handle removed messages in the base class
    }

    func startReceiveMessages() {

        /// The singleton can be injected as a dependency. However, from an
        /// informational perspective, this example calls FriendsChatService
        /// directly to illustrate the intent of the pattern, which is: "...to
        /// provide the global point of access to the instance..."

        FriendsChatService.shared.add(subscriber: self)
    }
}

class MessagesListVC: BaseVC {

    override func accept(new messages: [Message]) {
        print("MessagesListVC accepted 'new messages'")
        /// handle new messages in the child class
    }

    override func accept(removed messages: [Message]) {
        print("MessagesListVC accepted 'removed messages'")
        /// handle removed messages in the child class
    }

    override func startReceiveMessages() {
        print("MessagesListVC starts receive messages")
        super.startReceiveMessages()
    }
}

class ChatVC: BaseVC {

    override func accept(new messages: [Message]) {
        print("ChatVC accepted 'new messages'")
        /// handle new messages in the child class
    }

    override func accept(removed messages: [Message]) {
        print("ChatVC accepted 'removed messages'")
        /// handle removed messages in the child class
    }

    override func startReceiveMessages() {
        print("ChatVC starts receive messages")
        super.startReceiveMessages()
    }
}

/// Protocol for call-back events

protocol MessageSubscriber {

    func accept(new messages: [Message])
    func accept(removed messages: [Message])
}

/// Protocol for communication with a message service

protocol MessageService {

    func add(subscriber: MessageSubscriber)
}

/// Message domain model

struct Message {

    let id: Int
    let text: String
}


class FriendsChatService: MessageService {

    static let shared = FriendsChatService()

    private var subscribers = [MessageSubscriber]()

    func add(subscriber: MessageSubscriber) {

        /// In this example, fetching starts again by adding a new subscriber
        subscribers.append(subscriber)

        /// Please note, the first subscriber will receive messages again when
        /// the second subscriber is added
        startFetching()
    }

    func startFetching() {

        /// Set up the network stack, establish a connection...
        /// ...and retrieve data from a server

        let newMessages = [Message(id: 0, text: "Text0"),
                           Message(id: 5, text: "Text5"),
                           Message(id: 10, text: "Text10")]

        let removedMessages = [Message(id: 1, text: "Text0")]

        /// Send updated data to subscribers
        receivedNew(messages: newMessages)
        receivedRemoved(messages: removedMessages)
    }
}

private extension FriendsChatService {

    func receivedNew(messages: [Message]) {

        subscribers.forEach { item in
            item.accept(new: messages)
        }
    }

    func receivedRemoved(messages: [Message]) {

        subscribers.forEach { item in
            item.accept(removed: messages)
        }
    }
}
