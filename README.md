# qoi

A WIP [Crystal](https://github.com/crystal-lang/crystal) implementation of the [Quite OK Image](https://qoiformat.org/) format.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     qoi:
       github: uncomfyhalomacro/qoi.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "qoi"

module YourModule
  include Qoi
end
```

## Contributing

1. Fork it (<https://github.com/uncomfyhalomacro/qoi.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Soc Virnyl S. Estela](https://github.com/uncomfyhalomacro) - creator and maintainer

# Relevant implementations I took ideas from

- [QOI.jl](https://github.com/KristofferC/QOI.jl)
