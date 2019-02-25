import XCTest

class VisitorRealExample: XCTestCase {

    func test() {

        let email = Email(emailOfSender: "some@email.com")
        let sms = SMS(phoneNumberOfSender: "+3806700000")
        let push = Push(usernameOfSender: "Spammer")

        let notifications: [Notification] = [email, sms, push]

        clientCode(handle: notifications, with: DefaultPolicyVisitor())

        clientCode(handle: notifications, with: NightPolicyVisitor())
    }
}

extension VisitorRealExample {

    /// Client code traverses notifications with visitors and checks whether
    /// a notification is in a blacklist and should be shown in accordance with
    /// a current SilencePolicy

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
