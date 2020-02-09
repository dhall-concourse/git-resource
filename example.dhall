let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let Git =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let resource =
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

let get =
    -- Use Git.InParams to define params for get
    -- And use Git.InParams.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.helpers.getStep
        Concourse.schemas.GetStep::{
        , resource = resource
        , params =
            Git.InParams.render
              Git.InParams::{
              , depth = Some 1
              , submodules = Some Git.InParams.Submodules.All
              }
        }

let put =
    -- Use Git.OutParams to define params for get
    -- And use Git.OutParams.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            Git.OutParams.render
              Git.OutParams::{ repository = resource.name, rebase = Some True }
        }

in  [ Concourse.schemas.Job::{ name = "git-example", plan = [ get, put ] } ]
