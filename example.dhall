let Concourse = ./deps/concourse.dhall

let Git = ./package.dhall

let resource =
      Concourse.schemas.Resource::{
      , name = "test-git"
      , type = Concourse.Types.ResourceType.InBuilt "git"
      , source =
          Git.Source.render
            Git.Source::{
            , uri = "https://github.com/dhall-concourse/git-resource.git"
            }
      }

in  [ Concourse.schemas.Job::{
      , name = "git-example"
      , plan =
        [ Concourse.helpers.getStep
            Concourse.schemas.GetStep::{
            , resource = resource
            , params =
                Git.InParams.render
                  Git.InParams::{
                  , depth = Some 1
                  , submodules = Some Git.InParams.Submodules.All
                  }
            }
        , Concourse.helpers.putStep
            Concourse.schemas.PutStep::{
            , resource = resource
            , params =
                Git.OutParams.render
                  Git.OutParams::{
                  , repository = resource.name
                  , rebase = Some True
                  }
            }
        ]
      }
    ]
