# Rubyisms in coffescript
puts = (arg) -> console.log(arg) if console
raise = (message) -> throw new Error(message)
abstract_method = -> raise "Subclass responsability"

# Define a method called methodName, with body func on the class given
define = (clas, methodName, func) -> clas.prototype[methodName] = func

# return the instance methods of a class.
methods = (clas) ->
    ret = c for c of clas.prototype
    return ret unless clas.__super__
    ret.concat methods clas.__super__.constructor

# return the instance methods of a class. Only compute if func of the superclass is true.
methodsWhile = (clas, func) ->
    return [] unless func(clas)
    ret = c for c of clas.prototype
    return ret unless clas.__super__
    ret.concat methodsWhile clas.__super__.constructor, func



# return the instance methods of a class of an instance
methodsOfInstance = (instance) -> methods instance.constructor

# Like methodsUntil, but works on an instance
methodsOfInstanceWhile = (instance, func) -> methodsWhile instance.constructor, func
