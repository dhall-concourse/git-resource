let Prelude = ../deps/prelude.dhall

let JSON = Prelude.JSON

let RenderOptional = ../deps/render-optionals.dhall

let renderReturning =
      λ(returning : ./Returning.dhall) →
        JSON.string
          (merge { Merged = "merged", Unmerged = "unmerged" } returning)

in  λ(p : ./Type.dhall) →
      Some
        ( toMap
            { repository = JSON.string p.repository
            , rebase = RenderOptional.bool p.rebase
            , `merge` = RenderOptional.bool p.`merge`
            , returning =
                RenderOptional.generic
                  ./Returning.dhall
                  renderReturning
                  p.returning
            , tag = RenderOptional.text p.tag
            , only_tag = RenderOptional.bool p.only_tag
            , tag_prefix = RenderOptional.text p.tag_prefix
            , force = RenderOptional.bool p.force
            , annotate = RenderOptional.text p.annotate
            , notes = RenderOptional.text p.notes
            , branch = RenderOptional.text p.branch
            }
        )
