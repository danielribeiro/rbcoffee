# Rubyisms in coffescript
puts = if @["console"]?
        Function.prototype.bind.call(console.log, console)
    else
        -> 

raise = (message) -> throw new Error(message)
abstract_method = -> raise "Subclass responsability"
abstract_property = -> raise "Abstract property"

# Returns a shalow clone of an object
clone = (obj) ->
    return obj unless obj?
    ret = {}
    for k, v of obj
        ret[k] = v
    return ret

# Mixins for objects. Example: Singleton = withMixin Trait, { mymethod: -> "output" }
withMixin = (mixed, obj) ->
    for name, m of mixed
        unless isAbstract(m) or (obj[name]? and not isAbstract(obj[name])))
            obj[name] = m
    return obj



eq = (x, y) -> return `x == y`

# Define a method called methodName, with body func on the class given
define = (clas, methodName, func) -> clas.prototype[methodName] = func

# Define all methods on the clas for each k, v in obj
patch = (clas, mixed) ->
    (define clas, name, method) for name, method of mixed
    return


isAbstract = (m) -> m == abstract_method or m == abstract_property

#adds all atributes of mixed into clas. For actual classes, it is the mixin semantics
#Will not override existing method with abstract methods of the mixxed class.
mixinWith = (clas, mixed) ->
    for name, m of mixed
        unless isAbstract(m) or
        (clas.prototype[name]? and not isAbstract(clas.prototype[name]))
            define clas, name, m
    return

# Like mixinWith, but accepts many traits.
mixin = (clas, traits...) ->
    for trait in traits
        mixinWith clas, trait
    return

# return the instance methods of a class.
methods = (clas) ->
    ret = (c for c of clas.prototype)
    return ret unless clas.__super__
    ret.concat methods clas.__super__.constructor

# return the instance methods of a class. Only compute if func of the superclass is true.
methodsWhile = (clas, func) ->
    return [] unless func(clas)
    ret = (c for c of clas.prototype)
    return ret unless clas.__super__
    ret.concat methodsWhile clas.__super__.constructor, func

# return the instance methods of a class of an instance
methodsOfInstance = (instance) -> methods instance.constructor

# Like methodsUntil, but works on an instance
methodsOfInstanceWhile = (instance, func) -> methodsWhile instance.constructor, func
