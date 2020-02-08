let Prelude = ../deps/prelude.dhall

let JSON = Prelude.JSON

let RenderOptional = ../deps/render-optionals.dhall

in    λ(p : ./Type.dhall)
    → Some
        ( toMap
            { depth = RenderOptional.natural p.depth
            , submodules =
                RenderOptional.generic
                  ./Submodules.dhall
                  (   λ(s : ./Submodules.dhall)
                    → merge
                        { None = JSON.string "none"
                        , All = JSON.string "all"
                        , Selected =
                              λ(xs : List Text)
                            → JSON.array
                                (Prelude.List.map Text JSON.Type JSON.string xs)
                        }
                        s
                  )
                  p.submodules
            , submodule_recursive = RenderOptional.bool p.submodule_recursive
            , submodule_remote = RenderOptional.bool p.submodule_remote
            , disable_git_lfs = RenderOptional.bool p.disable_git_lfs
            , clean_tags = RenderOptional.bool p.clean_tags
            , short_ref_format = RenderOptional.text p.short_ref_format
            }
        )
