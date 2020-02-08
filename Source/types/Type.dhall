{ uri : Text
, branch : Optional Text
, private_key : Optional Text
, forward_agent : Optional Bool
, username : Optional Text
, password : Optional Text
, paths : Optional (List Text)
, ignore_paths : Optional (List Text)
, skip_ssl_verification : Optional Bool
, tag_filter : Optional Text
, submodule_credentials : Optional ./SubmoduleCredentials.dhall
, git_config : Optional (List ./GitConfigItem.dhall)
, disable_ci_skip : Optional Bool
, commit_verification_keys : Optional (List Text)
, commit_verification_key_ids : Optional (List Text)
, gpg_keyserver : Optional Text
, git_crypt_key : Optional Text
, https_tunnel : Optional ./HttpsTunnel.dhall
, commit_filter : Optional ./CommitFilter.dhall
}
