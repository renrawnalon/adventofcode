var registry = CommandRegistry(usage: "<command> <options>", overview: "Basic Calculator")

registry.register(command: AdditionCommand.self)

registry.run()
