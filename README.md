# Design Patterns in Swift

This repository is part of the [Refactoring.Guru](https://refactoring.guru/design-patterns) project.

It contains Swift examples for all classic GoF design patterns.

There are two examples for each of the patterns:

- **Conceptual** examples illustrate the internal structure of a pattern, explained with detailed comments.

- **RealWorld** examples illustrate how patterns can be used in real-world Swift applications.


## Requirements

For the best experience, we recommend working with examples with [Swift 4](https://github.com/apple/swift) and [Xcode](https://developer.apple.com/xcode/) IDE.


## Usage

For the sake of simplicity, we tried to limit the scope of these examples to the code, related to the actual patterns. That's why didn't implement full-blown Swift apps, accompanied with Run targets. Instead, our examples are packaged as unit tests, where each Unit Test target executes a specific example of a pattern.

To run an example, browse it in the project directory, select the Unit Test scheme and launch the example.

![How to launch an example](/readme.gif?raw=true)


## FAQ

#### 1. What is the _Client Code_?

_Client_ means _client of classes, defined as part of a pattern_, which is merely a caller of the given methods or a user of the given classes. In other words, it's the part of your application's code that uses the pattern's classes.

#### 2. I don't understand the roles you're referring to in RealWorld examples.

Take a look at the structural example first. There you'll find detailed descriptions of each class in a pattern, its role, and connection to other classes.


## License

This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/80x15.png" /></a>


## Credits

"Design Patterns in Swift" were created by [Maxim Eremenko](https://www.linkedin.com/in/maxim-eremenko/) for Refactoring.Guru.