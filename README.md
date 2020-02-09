# dhall-concourse/git-resource

[dhall-concourse](https://github.com/akshaymankar/dhall-concourse) bindings for [git-resource](https://github.com/concourse/git-resource)

## Usage

### Source

To define a resource with source rendered by this package, you can use the `Source` type like this: 

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let Git =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myGitResource =
    -- Use Git.Source to define source.
    -- And use Git.Source.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.schemas.Resource::{
      , name = "test-git"
      , type = Concourse.Types.ResourceType.InBuilt "git"
      , source =
          Git.Source.render
            Git.Source::{
            , uri = "https://github.com/dhall-concourse/git-resource.git"
            }
      }
in myGitResource
```

The `Source` type supports all parameters accepted by the git-resource.
You can look at the full type [here](Source/types/Type.dhall).

For detailed explanation please refer to the [git-resource README](https://github.com/concourse/git-resource/blob/master/README.md)

### InParams (params for the `get` step)

To define the `params` for `get` step to get a git resource, you can use the `InParams` type like this: 

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let Git =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myGitResource = ./resource-defined-earlier.dhall

let getStep =
    -- Use Git.InParams to define params for get
    -- And use Git.InParams.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.helpers.getStep
        Concourse.schemas.GetStep::{
        , resource = myGitResource
        , params =
            Git.InParams.render
              Git.InParams::{
              , depth = Some 1
              , submodules = Some Git.InParams.Submodules.All
              }
        }
        
in getStep
```

This type also supports all parameters supported by the git resource.
The type is defined [here](InParams/Type.dhall) and the detailed explanation is on the [git resource README](https://github.com/concourse/git-resource/blob/master/README.md#in-clone-the-repository-at-the-given-ref)

### OutParams (params for the `put` step)


To define the `params` for `put` step to get a git resource, you can use the `OutParams` type like this: 

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let Git =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myGitResource = ./resource-defined-earlier.dhall

let putStep =
    -- Use Git.OutParams to define params for put
    -- And use Git.OutParams.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            Git.OutParams.render
              Git.OutParams::{ repository = resource.name, rebase = Some True }
        }
        
in putStep
```

This type also supports all parameters supported by the git resource.
The type is defined [here](OutParams/Type.dhall) and the detailed explanation is on the [git resource README](https://github.com/concourse/git-resource/blob/master/README.md#out-push-to-a-repository)
