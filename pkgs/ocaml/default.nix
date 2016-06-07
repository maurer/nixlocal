{lib, pkgs}:

let
  ocamlP   = pkgs.mkOcamlPackages pkgs.ocaml_4_02 (ocamlP // self);
  camlCall = lib.callPackageWith (pkgs // ocamlP // self);
  self = rec {
    piqi = camlCall ./piqi {};
    piqi-ocaml = camlCall ./piqi-ocaml {};
    buildOcamlJane = camlCall ./buildOcamlJane.nix {};
    uri = camlCall ./uri {};
    cstruct = camlCall ./cstruct {};
    async = camlCall ./async {};
    async_kernel = camlCall ./async_kernel {};
    async_unix = camlCall ./async_unix {};
    async_extra = camlCall ./async_extra {};
    async_rpc_kernel = camlCall ./async_rpc_kernel {};
    bin_prot = camlCall ./bin_prot.nix {};
    fieldslib = camlCall ./fieldslib.nix {};
    sexplib = camlCall ./sexplib.nix {};
    typerep = camlCall ./typerep.nix {};
    variantslib = camlCall ./variantslib.nix {};
    core_kernel = camlCall ./core_kernel.nix {};
    ocamlgraph = camlCall ./ocamlgraph {};
    core = camlCall ./core {};
    ppx_assert = camlCall ./ppx-assert.nix {};
    ppx_bench = camlCall ./ppx-bench.nix {};
    ppx_bin_prot = camlCall ./ppx-bin-prot.nix {};
    ppx_compare = camlCall ./ppx-compare.nix {};
    ppx_core = camlCall ./ppx-core.nix {};
    ppx_custom_printf = camlCall ./ppx-custom-printf.nix {};
    ppx_deriving = camlCall ./ppx-deriving.nix {};
    ppx_driver = camlCall ./ppx-driver.nix {};
    ppx_enumerate = camlCall ./ppx-enumerate.nix {};
    ppx_expect = camlCall ./ppx-expect.nix {};
    ppx_fail = camlCall ./ppx-fail.nix {};
    ppx_fields_conv = camlCall ./ppx-fields-conv.nix {};
    ppx_here = camlCall ./ppx-here.nix {};
    ppx_inline_test = camlCall ./ppx-inline-test.nix {};
    ppx_jane = camlCall ./ppx-jane.nix {};
    ppx_let = camlCall ./ppx-let.nix {};
    ppx_optcomp = camlCall ./ppx-optcomp.nix {};
    ppx_pipebang = camlCall ./ppx-pipebang.nix {};
    ppx_sexp_conv = camlCall ./ppx-sexp-conv.nix {};
    ppx_sexp_message = camlCall ./ppx-sexp-message.nix {};
    ppx_sexp_value = camlCall ./ppx-sexp-value.nix {};
    ppx_type_conv = camlCall ./ppx-type-conv.nix {};
    ppx_typerep_conv = camlCall ./ppx-typerep-conv.nix {};
    ppx_variants_conv = camlCall ./ppx-variants-conv.nix {};
    js_build_tools = camlCall ./js-build-tools.nix {};
    bap = camlCall ./bap.nix {};
    libbap = camlCall ./libbap.nix {};
    bil = camlCall ./bil.nix {};
    caml_bz2 = camlCall ./camlbz2.nix {};
    frontc = camlCall ./frontc.nix {};
    ocamlPackages = ocamlP;
    ocaml_curses = camlCall ./ocaml-curses.nix {};
    ofuzz = camlCall ./ofuzz.nix {};
    ocaml_libinput = camlCall ./input.nix {};
    symfuzz = camlCall ./symfuzz.nix {};
  };
in
self
