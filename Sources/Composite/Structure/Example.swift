import XCTest

/// EN: Composite Design Pattern
///
/// Intent: Compose objects into tree structures to represent part-whole
/// hierarchies. Composite lets clients treat individual objects and compositions
/// of objects uniformly.
///
/// RU: Паттерн Компоновщик
///
/// Назначение: Объединяет объекты в древовидные структуры для представления
/// иерархий часть-целое. Компоновщик позволяет клиентам обрабатывать отдельные
/// объекты и группы объектов одинаковым образом.


/// EN: The base Component class declares common operations for both simple and
/// complex objects of a composition.
///
/// RU: Базовый класс Компонент объявляет общие операции как для простых, так и
/// для сложных объектов структуры.
protocol Component {
    /// EN: The base Component may optionally declare methods for setting
    /// and accessing a parent of the component in a tree structure. It can also
    /// provide some default implementation for these methods.
    ///
    /// RU: При необходимости базовый Компонент может объявить интерфейс для
    /// установки и получения родителя компонента в древовидной структуре. Он
    /// также может предоставить  некоторую реализацию по умолчанию для этих
    /// методов.
    var parent: Component? { get set }

    /// EN: In some cases, it would be beneficial to define the child-management
    /// operations right in the base Component class. This way, you won't need to
    /// expose any concrete component classes to the client code, even during the
    /// object tree assembly. The downside is that these methods will be empty
    /// for the leaf-level components.
    ///
    /// RU: В некоторых случаях целесообразно определить операции управления
    /// потомками прямо в базовом классе Компонент. Таким образом, вам не нужно
    /// будет предоставлять  конкретные классы компонентов клиентскому коду, даже
    /// во время сборки дерева объектов. Недостаток такого подхода в том, что эти
    /// методы будут пустыми для компонентов уровня листа.
    func add(component: Component)
    func remove(component: Component)

    /// EN: You can provide a method that lets the client code figure out whether
    /// a component can bear children.
    ///
    /// RU: Вы можете предоставить метод, который позволит клиентскому коду
    /// понять, может ли компонент иметь вложенные объекты.
    func isComposite() -> Bool

    /// EN: The base Component may implement some default behavior or leave it to
    /// concrete classes.
    ///
    /// RU: Базовый Компонент может сам реализовать некоторое поведение по
    /// умолчанию или поручить это конкретным классам.
    func operation() -> String
}

extension Component {
    func add(component: Component) {}
    func remove(component: Component) {}
    func isComposite() -> Bool {
        return false
    }
}

/// EN: The Leaf class represents the end objects of a composition. A leaf can't
/// have any children.
///
/// Usually, it's the Leaf objects that do the actual work, whereas Composite
/// objects only delegate to their sub-components.
///
/// RU: Класс Лист представляет собой конечные объекты структуры.  Лист не может
/// иметь вложенных компонентов.
///
/// Обычно объекты Листьев выполняют фактическую работу, тогда как объекты
/// Контейнера лишь делегируют работу своим подкомпонентам.
class Leaf: Component {
    var parent: Component?

    func operation() -> String {
        return "Leaf"
    }
}

/// EN: The Composite class represents the complex components that may have
/// children. Usually, the Composite objects delegate the actual work to their
/// children and then "sum-up" the result.
///
/// RU: Класс Контейнер содержит сложные компоненты, которые могут иметь
/// вложенные компоненты. Обычно объекты Контейнеры делегируют фактическую работу
/// своим детям, а затем «суммируют» результат.
class Composite: Component {
    var parent: Component?

    /// EN: This fields contains the conponent subtree.
    ///
    /// RU: Это поле содержит поддерево компонентов.
    private var children = [Component]()

    /// EN: A composite object can add or remove other components (both simple or
    /// complex) to or from its child list.
    ///
    /// RU: Объект контейнера может как добавлять компоненты в свой список
    /// вложенных компонентов, так и удалять их, как простые, так и сложные.
    func add(component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }

    func remove(component: Component) {
        // ...
    }

    func isComposite() -> Bool {
        return true
    }

    /// EN: The Composite executes its primary logic in a particular way. It
    /// traverses recursively through all its children, collecting and summing
    /// their results. Since the composite's children pass these calls to their
    /// children and so forth, the whole object tree is traversed as a result.
    ///
    /// RU: Контейнер выполняет свою основную логику особым образом. Он проходит
    /// рекурсивно через всех своих детей, собирая и суммируя их результаты.
    /// Поскольку потомки контейнера передают эти вызовы своим потомкам и так
    /// далее,  в результате обходится всё дерево объектов.
    func operation() -> String {
        let result = children.map({ $0.operation() })
        return "Branch(" + result.joined(separator: " ") + ")"
    }
}

class Client {
    /// EN: The client code works with all of the components via the base interface.
    ///
    /// RU: Клиентский код работает со всеми компонентами через базовый интерфейс.
    static func someClientCode(component: Component) {
        print("Result: " + component.operation())
    }

    /// EN: Thanks to the fact that the child-management operations are also declared in
    /// the base Component class, the client code can work with both simple
    /// or complex components.
    ///
    /// RU: Благодаря тому, что операции управления потомками объявлены в базовом
    /// классе Компонента, клиентский код может работать как с простыми, так и со
    /// сложными компонентами.
    static func moreComplexClientCode(leftComponent: Component, rightComponent: Component) {
        if leftComponent.isComposite() {
            leftComponent.add(component: rightComponent)
        }
        print("Result: " + leftComponent.operation())
    }
}

/// EN: Let's see how it all comes together.
///
/// RU: Давайте посмотрим как всё это будет работать.
class CompositeStructuralExample: XCTestCase {
    func testCompositeStructure() {

        /// EN: This way the client code can support the simple leaf components...
        ///
        /// RU: Таким образом, клиентский код может поддерживать простые
        /// компоненты-листья...
        print("Client: I've got a simple component:")
        Client.someClientCode(component: Leaf())

        /// EN: ...as well as the complex composites.
        ///
        /// RU: ...а также сложные контейнеры.
        let tree = Composite()

        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())

        let branch2 = Composite()
        branch2.add(component: Leaf())
        branch2.add(component: Leaf())

        tree.add(component: branch1)
        tree.add(component: branch2)

        print("\nClient: Now I've got a composite tree:")
        Client.someClientCode(component: tree)

        print("\nClient: I don't need to check the components classes even when managing the tree:")
        Client.moreComplexClientCode(leftComponent: tree, rightComponent: Leaf())
    }
}
