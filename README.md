# Easy-Decodable

A number of convenience tools to simplify custom types decoding without needing to override compiler-syntesized decoding initializer.

# Usage

The package provides two property wrappers: `@CodableValue<Value>` and `@RecoverableCodableValue<Value, DefaultValue>`. 
Use the first one if no default value is needed. 
If you need some sort of default value to be assigned when no value has been found, provide the second one with a type conforming to `CodableRawValueType` protocol. 

# Contributions

Thanks to [NewDev](https://stackoverflow.com/users/968155/new-dev) for helping out with optional issue.
