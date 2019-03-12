import Foundation
import XCTest


protocol Notification: CustomStringConvertible {

    func accept(visitor: NotificationPolicy) -> Bool
}

struct Email {

    let emailOfSender: String

    var description: String { return "Email" }
}

struct SMS {

    let phoneNumberOfSender: String

    var description: String { return "SMS" }
}

struct Push {

    let usernameOfSender: String

    var description: String { return "Push" }
}

extension Email: Notification {

    func accept(visitor: NotificationPolicy) -> Bool {
        return visitor.isTurnedOn(for: self)
    }
}

extension SMS: Notification {

    func accept(visitor: NotificationPolicy) -> Bool {
        return visitor.isTurnedOn(for: self)
    }
}

extension Push: Notification {

    func accept(visitor: NotificationPolicy) -> Bool {
        return visitor.isTurnedOn(for: self)
    }
}


protocol NotificationPolicy: CustomStringConvertible {

    func isTurnedOn(for email: Email) -> Bool

    func isTurnedOn(for sms: SMS) -> Bool

    func isTurnedOn(for push: Push) -> Bool
}

class NightPolicyVisitor: NotificationPolicy {

    func isTurnedOn(for email: Email) -> Bool {
        return false
    }

    func isTurnedOn(for sms: SMS) -> Bool {
        return true
    }

    func isTurnedOn(for push: Push) -> Bool {
        return false
    }

    var description: String { return "Night Policy Visitor" }
}

class DefaultPolicyVisitor: NotificationPolicy {

    func isTurnedOn(for email: Email) -> Bool {
        return true
    }

    func isTurnedOn(for sms: SMS) -> Bool {
        return true
    }

    func isTurnedOn(for push: Push) -> Bool {
        return true
    }

    var description: String { return "Default Policy Visitor" }
}

class BlackListVisitor: NotificationPolicy {

    private var bannedEmails = [String]()
    private var bannedPhones = [String]()
    private var bannedUsernames = [String]()

    init(emails: [String], phones: [String], usernames: [String]) {
        self.bannedEmails = emails
        self.bannedPhones = phones
        self.bannedUsernames = usernames
    }

    func isTurnedOn(for email: Email) -> Bool {
        return bannedEmails.contains(email.emailOfSender)
    }

    func isTurnedOn(for sms: SMS) -> Bool {
        return bannedPhones.contains(sms.phoneNumberOfSender)
    }

    func isTurnedOn(for push: Push) -> Bool {
        return bannedUsernames.contains(push.usernameOfSender)
    }

    var description: String { return "Black List Visitor" }
}



class VisitorRealWorld: XCTestCase {

    func testVisitorRealWorld() {

        let email = Email(emailOfSender: "some@email.com")
        let sms = SMS(phoneNumberOfSender: "+3806700000")
        let push = Push(usernameOfSender: "Spammer")

        let notifications: [Notification] = [email, sms, push]

        clientCode(handle: notifications, with: DefaultPolicyVisitor())

        clientCode(handle: notifications, with: NightPolicyVisitor())
    }
}

extension VisitorRealWorld {

    /// Client code traverses notifications with visitors and checks whether a
    /// notification is in a blacklist and should be shown in accordance with a
    /// current SilencePolicy

    func clientCode(handle notifications: [Notification], with policy: NotificationPolicy) {

        let blackList = createBlackList()

        print("\nClient: Using \(policy.description) and \(blackList.description)")

        notifications.forEach { item in

            guard !item.accept(visitor: blackList) else {
                print("\tWARNING: " + item.description + " is in a black list")
                return
            }

            if item.accept(visitor: policy) {
                print("\t" + item.description + " notification will be shown")
            } else {
                print("\t" + item.description + " notification will be silenced")
            }
        }
    }

    private func createBlackList() -> BlackListVisitor {
        return BlackListVisitor(emails: ["banned@email.com"],
                                phones: ["000000000", "1234325232"],
                                usernames: ["Spammer"])
    }
}
