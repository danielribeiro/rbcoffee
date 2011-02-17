# Rubyisms in coffescript
puts = (args...) ->
    return unless console
    for arg in args
        console.log(arg)
    return
raise = (message) -> throw new Error(message)
abstract_method = -> raise "Subclass responsability"
abstract_property = -> raise "Abstract property"

# Define a method called methodName, with body func on the class given
define = (clas, methodName, func) -> clas.prototype[methodName] = func

# Define all methods on the clas for each k, v in obj
patch = (clas, mixed) ->
    (define clas, name, method) for name, method of mixed
    return

#adds all atributes of mixed into clas. For actual classes, it is the mixin semantics
#Will not override existing method with abstract methods of the mixxed class.
mixinWith = (clas, mixed) ->
    for name, m of mixed
        unless clas.prototype[name]? and (m == abstract_method or m == abstract_property)
            define clas, name, m
    return

# Like mixinWith, but accepts many traits.
mixin = (clas, traits...) ->
    for trait in traits
        mixinWith clas, trait
    return

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
