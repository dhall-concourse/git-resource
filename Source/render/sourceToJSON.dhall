let Prelude = ../../deps/prelude.dhall

let JSON = Prelude.JSON

let RenderOptional = ../../deps/render-optionals.dhall

in  λ(git : ../types/Type.dhall) →
      Some
        ( toMap
            { uri = JSON.string git.uri
            , branch = RenderOptional.text git.branch
            , private_key = RenderOptional.text git.private_key
            , forward_agent = RenderOptional.bool git.forward_agent
            , username = RenderOptional.text git.username
            , password = RenderOptional.text git.password
            , paths = RenderOptional.lists.text git.paths
            , ignore_paths = RenderOptional.lists.text git.ignore_paths
            , skip_ssl_verification =
                RenderOptional.bool git.skip_ssl_verification
            , tag_filter = RenderOptional.text git.tag_filter
            , submodule_credentials =
                RenderOptional.generic
                  ../types/SubmoduleCredentials.dhall
                  ( λ(creds : ../types/SubmoduleCredentials.dhall) →
                      JSON.object
                        ( toMap
                            { host = JSON.string creds.host
                            , username = JSON.string creds.username
                            , password = JSON.string creds.password
                            }
                        )
                  )
                  git.submodule_credentials
            , git_config =
                RenderOptional.lists.generic
                  ../types/GitConfigItem.dhall
                  ( λ(cfg : ../types/GitConfigItem.dhall) →
                      JSON.object
                        ( toMap
                            { name = JSON.string cfg.name
                            , value = JSON.string cfg.value
                            }
                        )
                  )
                  git.git_config
            , disable_ci_skip = RenderOptional.bool git.disable_ci_skip
            , commit_verification_keys =
                RenderOptional.lists.text git.commit_verification_keys
            , commit_verification_key_ids =
                RenderOptional.lists.text git.commit_verification_key_ids
            , gpg_keyserver = RenderOptional.text git.gpg_keyserver
            , git_crypt_key = RenderOptional.text git.git_crypt_key
            , https_tunnel =
                RenderOptional.generic
                  ../types/HttpsTunnel.dhall
                  ( λ(https_tunnel : ../types/HttpsTunnel.dhall) →
                      JSON.object
                        ( toMap
                            { proxy_host = JSON.string https_tunnel.proxy_host
                            , proxy_port = JSON.string https_tunnel.proxy_port
                            , proxy_user =
                                RenderOptional.text https_tunnel.proxy_user
                            , proxy_password =
                                RenderOptional.text https_tunnel.proxy_password
                            }
                        )
                  )
                  git.https_tunnel
            , commit_filter =
                RenderOptional.generic
                  ../types/CommitFilter.dhall
                  ( λ(commit_filter : ../types/CommitFilter.dhall) →
                      JSON.object
                        ( toMap
                            { exclude =
                                RenderOptional.lists.text commit_filter.exclude
                            , include =
                                RenderOptional.lists.text commit_filter.include
                            }
                        )
                  )
                  git.commit_filter
            }
        )
