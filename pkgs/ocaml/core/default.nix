{stdenv, buildOcamlJane, fetchurl, type_conv,
 core_kernel, bin_prot, comparelib, ppx_custom_printf, enumerate,
 fieldslib, herelib,
 pipebang, sexplib, typerep, variantslib}:

buildOcamlJane rec {
  name = "core";
  hash = "0nz6d5glgymbpchvcpw77yis9jgi2bll32knzy9vx99wn83zdrmd";

  propagatedBuildInputs = [ type_conv core_kernel bin_prot comparelib
                            ppx_custom_printf enumerate fieldslib herelib
                            pipebang sexplib typerep variantslib ];

  meta = with stdenv.lib; {
    homepage = https://github.com/janestreet/core;
    description = "Jane Street Capital's standard library overlay";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
