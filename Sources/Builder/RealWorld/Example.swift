import XCTest

class BuilderRealWorldExample: XCTestCase {

    func testRealBuilder() {
        print("Client: Start fetching data from Realm")
        clientCode(builder: RealmQueryBuilder<User>())

        print()

        print("Client: Start fetching data from CoreData")
        clientCode(builder: CoreDataQueryBuilder<User>())
    }

    fileprivate func clientCode(builder: BaseQueryBuilder<User>) {

        let results = builder.filter({ $0.age < 20 })
            .limit(1)
            .fetch()

        print("Client: I have fetched: " + String(results.count) + " records.")
    }
}

protocol DomainModel {
    /// The protocol groups domain models to the common interface
}

private struct User: DomainModel {
    let id: Int
    let age: Int
    let email: String
}
