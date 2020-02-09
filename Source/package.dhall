{ Type =
      ./types/Type.dhall sha256:7c9dc89127cf1dd3a158bd3e6949c96dded11395e7809d6ce8d9c327b191ef77
    ? ./types/Type.dhall
, default =
      ./defaults/Source.dhall sha256:4bd6fcf80a6220076c03bb4ae47dedd128f5a09a1af926a67ae0760ce80c4312
    ? ./defaults/Source.dhall
, render =
      ./render/sourceToJSON.dhall sha256:803f8f3f9cafce273cbebcc122516866c7d468eebf46420ca927d344a1a722f3
    ? ./render/sourceToJSON.dhall
}
