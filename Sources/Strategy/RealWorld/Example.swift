import XCTest

class StrategyRealWorld: XCTestCase {

    /// This example shows a simple implementation of a list controller that is
    /// able to display models from different data sources:
    ///
    /// (MemoryStorage, CoreDataStorage, RealmStorage)

    func test() {

        let controller = ListController()

        let memoryStorage = MemoryStorage<User>()
        memoryStorage.add(usersFromNetwork())

        clientCode(use: controller, with: memoryStorage)

        clientCode(use: controller, with: CoreDataStorage())

        clientCode(use: controller, with: RealmStorage())
    }

    func clientCode(use controller: ListController, with dataSource: DataSource) {

        controller.update(dataSource: dataSource)
        controller.displayModels()
    }

    private func usersFromNetwork() -> [User] {
        let firstUser = User(id: 1, username: "username1")
        let secondUser = User(id: 2, username: "username2")
        return [firstUser, secondUser]
    }
}

class ListController {

    private var dataSource: DataSource?

    func update(dataSource: DataSource) {
        /// ... resest current states ...
        self.dataSource = dataSource
    }

    func displayModels() {

        guard let dataSource = dataSource else { return }
        let models = dataSource.loadModels() as [User]

        /// Bind models to cells of a list view...
        print("\nListController: Displaying models...")
        models.forEach({ print($0) })
    }
}

protocol DataSource {

    func loadModels<T: DomainModel>() -> [T]
}

class MemoryStorage<Model>: DataSource {

    private lazy var items = [Model]()

    func add(_ items: [Model]) {
        self.items.append(contentsOf: items)
    }

    func loadModels<T: DomainModel>() -> [T] {
        guard T.self == User.self else { return [] }
        return items as! [T]
    }
}

class CoreDataStorage: DataSource {

    func loadModels<T: DomainModel>() -> [T] {
        guard T.self == User.self else { return [] }

        let firstUser = User(id: 3, username: "username3")
        let secondUser = User(id: 4, username: "username4")

        return [firstUser, secondUser] as! [T]
    }
}

class RealmStorage: DataSource {

    func loadModels<T: DomainModel>() -> [T] {
        guard T.self == User.self else { return [] }

        let firstUser = User(id: 5, username: "username5")
        let secondUser = User(id: 6, username: "username6")

        return [firstUser, secondUser] as! [T]
    }
}

protocol DomainModel {

    var id: Int { get }
}

struct User: DomainModel {

    var id: Int
    var username: String
}
