# Do not edit this file - Generated by MiniPerl6
use v6-alpha;
class CompUnit { has $.name; has $.attributes; has $.methods; has $.body; method emit { do { [] }; my  $a = @.body; my  $item; my  $in = ''; my  $s = ''; my  $node = 0; my  $s = ($s ~ ($in ~ ('"past" => PMC \'Past::Block\' {' ~ Main::newline()))); my  $in = '  '; my  $s = ($s ~ ($in ~ ('<mydecl> => Hash {' ~ Main::newline()))); my  $in = '      '; my  $s = ($s ~ ($in ~ ('"$_" => 1' ~ Main::newline()))); my  $in = '  '; my  $s = ($s ~ ($in ~ ('}' ~ Main::newline()))); my  $s = ($s ~ ($in ~ ('<source> => ""' ~ (Main::newline() ~ ($in ~ ('<pos> => 0' ~ (Main::newline() ~ ($in ~ ('<name> => "anon"' ~ Main::newline()))))))))); my  $s = ($s ~ ($in ~ ('<symtable> => Hash {' ~ Main::newline()))); my  $in = '      '; my  $s = ($s ~ ($in ~ ('"$!" => Hash {' ~ (Main::newline() ~ ($in ~ ('    "scope" => "package"' ~ (Main::newline() ~ ($in ~ ('}' ~ (Main::newline() ~ ($in ~ ('"$/" => Hash {' ~ (Main::newline() ~ ($in ~ ('    "scope" => "lexical"' ~ (Main::newline() ~ ($in ~ ('}' ~ (Main::newline() ~ ($in ~ ('"$_" => Hash {' ~ (Main::newline() ~ ($in ~ ('    "scope" => "lexical"' ~ (Main::newline() ~ ($in ~ ('}' ~ Main::newline()))))))))))))))))))))))))))); my  $in = '  '; my  $s = ($s ~ ($in ~ ('}' ~ Main::newline()))); my  $s = ($s ~ ($in ~ ('[' ~ ($node ~ ('] => \'PMC::Past::Var\' {' ~ (Main::newline() ~ ($in ~ ('    <name> => "$_"' ~ (Main::newline() ~ ($in ~ ('    <scope> => "lexical"' ~ (Main::newline() ~ ($in ~ ('    <ismy> => 1' ~ (Main::newline() ~ ($in ~ ('}' ~ Main::newline()))))))))))))))))); $node = ($node + 1); my  $s = ($s ~ ($in ~ ('[' ~ ($node ~ ('] => \'PMC::Past::Var\' {' ~ (Main::newline() ~ ($in ~ ('    <name> => "$/"' ~ (Main::newline() ~ ($in ~ ('    <scope> => "lexical"' ~ (Main::newline() ~ ($in ~ ('    <ismy> => 1' ~ (Main::newline() ~ ($in ~ ('}' ~ Main::newline()))))))))))))))))); $node = ($node + 1); do { for ( @($a) ) -> $item { do { if (($item.isa('Decl') && ($item.decl() ne 'has'))) { $s = ($s ~ $item.emit()) } else {  } } } }; do { for ( @($a) ) -> $item { do { if (($item.isa('Sub') || $item.isa('Method'))) { $s = ($s ~ $item.emit()) } else {  } } } }; do { for ( @($a) ) -> $item { do { if (($item.isa('Decl') && ($item.decl() eq 'has'))) { my  $name = $item.var().name();$s = ($s ~ ('.sub ' ~ (Main::quote() ~ ($name ~ (Main::quote() ~ (' :method' ~ (Main::newline() ~ ('  .param pmc val      :optional' ~ (Main::newline() ~ ('  .param int has_val  :opt_flag' ~ (Main::newline() ~ ('  unless has_val goto ifelse' ~ (Main::newline() ~ ('  setattribute self, ' ~ (Main::quote() ~ ($name ~ (Main::quote() ~ (', val' ~ (Main::newline() ~ ('  goto ifend' ~ (Main::newline() ~ ('ifelse:' ~ (Main::newline() ~ ('  val = getattribute self, ' ~ (Main::quote() ~ ($name ~ (Main::quote() ~ (Main::newline() ~ ('ifend:' ~ (Main::newline() ~ ('  .return(val)' ~ (Main::newline() ~ ('.end' ~ (Main::newline() ~ Main::newline())))))))))))))))))))))))))))))))))) } else {  } } } }; $s = ($s ~ ('.sub _ :anon :load :init :outer(' ~ (Main::quote() ~ ('_class_vars_' ~ (Main::quote() ~ (')' ~ (Main::newline() ~ ('  .local pmc self' ~ (Main::newline() ~ ('  newclass self, ' ~ (Main::quote() ~ ($.name ~ (Main::quote() ~ Main::newline()))))))))))))); do { for ( @($a) ) -> $item { do { if (($item.isa('Decl') && ($item.decl() eq 'has'))) { $s = ($s ~ $item.emit()) } else {  } };do { if (($item.isa('Decl') || ($item.isa('Sub') || $item.isa('Method')))) {  } else { $s = ($s ~ $item.emit()) } } } }; $s = ($s ~ ('}' ~ Main::newline())); return($s) }} 
;
class Val::Int { has $.int; method emit { do { [] }; ('[0] => PMC \'PAST::Val\'  {' ~ (Main::newline() ~ ('  <vtype> => ".Integer"' ~ (Main::newline() ~ ('  <name> => ' ~ ($.int ~ (Main::newline() ~ ('}' ~ Main::newline())))))))) }} 
;
class Val::Bit { has $.bit; method emit { do { [] }; ('[0] => PMC \'PAST::Val\'  {' ~ (Main::newline() ~ ('  <vtype> => ".Integer"' ~ (Main::newline() ~ ('  <name> => ' ~ ($.bit ~ (Main::newline() ~ ('}' ~ Main::newline())))))))) }} 
;
class Val::Num { has $.num; method emit { do { [] }; ('[0] => PMC \'PAST::Val\'  {' ~ (Main::newline() ~ ('  <vtype> => ".Float"' ~ (Main::newline() ~ ('  <name> => ' ~ ($.num ~ (Main::newline() ~ ('}' ~ Main::newline())))))))) }} 
;
class Val::Buf { has $.buf; method emit { do { [] }; ('[0] => PMC \'PAST::Val\'  {' ~ (Main::newline() ~ ('  <vtype> => ".String"' ~ (Main::newline() ~ ('  <name> => ' ~ (Main::quote() ~ ($.buf ~ (Main::quote() ~ (Main::newline() ~ ('}' ~ Main::newline())))))))))) }} 
;
class Val::Undef { method emit { do { [] }; die('Val::Undef - not yet possible'); ('[0] => PMC \'PAST::Op\'  {' ~ (Main::newline() ~ ('  <pasttype> => \'inline\'' ~ (Main::newline() ~ ('  <inline> => \'%r = new .Undef\'' ~ (Main::newline() ~ ('}' ~ Main::newline()))))))) }} 
;
class Val::Object { has $.class; has $.fields; method emit { do { [] }; die('Val::Object - not used yet') }} 
;
class Lit::Seq { has $.seq; method emit { do { [] }; die('Lit::Seq - not used yet') }} 
;
class Lit::Array { has $.array; method emit { do { [] }; my  $a = @.array; my  $item; my  $s = ('  save $P1' ~ (Main::newline() ~ ('  $P1 = new .ResizablePMCArray' ~ Main::newline()))); do { for ( @($a) ) -> $item { $s = ($s ~ $item.emit());$s = ($s ~ ('  push $P1, $P0' ~ Main.newline())) } }; my  $s = ($s ~ ('  $P0 = $P1' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))); return($s) }} 
;
class Lit::Hash { has $.hash; method emit { do { [] }; my  $a = @.hash; my  $item; my  $s = ('  save $P1' ~ (Main::newline() ~ ('  save $P2' ~ (Main::newline() ~ ('  $P1 = new .Hash' ~ Main::newline()))))); do { for ( @($a) ) -> $item { $s = ($s ~ $item.[0].emit());$s = ($s ~ ('  $P2 = $P0' ~ Main.newline()));$s = ($s ~ $item.[1].emit());$s = ($s ~ ('  set $P1[$P2], $P0' ~ Main.newline())) } }; my  $s = ($s ~ ('  $P0 = $P1' ~ (Main::newline() ~ ('  restore $P2' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))))); return($s) }} 
;
class Lit::Code { method emit { do { [] }; die('Lit::Code - not used yet') }} 
;
class Lit::Object { has $.class; has $.fields; method emit { do { [] }; my  $fields = @.fields; my  $str = ''; $str = ('  save $P1' ~ (Main::newline() ~ ('  save $S2' ~ (Main::newline() ~ ('  $P1 = new ' ~ (Main::quote() ~ ($.class ~ (Main::quote() ~ Main::newline())))))))); do { for ( @($fields) ) -> $field { $str = ($str ~ ($field.[0].emit() ~ ('  $S2 = $P0' ~ (Main::newline() ~ ($field.[1].emit() ~ ('  setattribute $P1, $S2, $P0' ~ Main::newline())))))) } }; $str = ($str ~ ('  $P0 = $P1' ~ (Main::newline() ~ ('  restore $S2' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))))); $str }} 
;
class Index { has $.obj; has $.index; method emit { do { [] }; my  $s = ('  save $P1' ~ Main::newline()); $s = ($s ~ $.obj.emit()); $s = ($s ~ ('  $P1 = $P0' ~ Main.newline())); $s = ($s ~ $.index.emit()); $s = ($s ~ ('  $P0 = $P1[$P0]' ~ Main.newline())); my  $s = ($s ~ ('  restore $P1' ~ Main::newline())); return($s) }} 
;
class Lookup { has $.obj; has $.index; method emit { do { [] }; my  $s = ('  save $P1' ~ Main::newline()); $s = ($s ~ $.obj.emit()); $s = ($s ~ ('  $P1 = $P0' ~ Main.newline())); $s = ($s ~ $.index.emit()); $s = ($s ~ ('  $P0 = $P1[$P0]' ~ Main.newline())); my  $s = ($s ~ ('  restore $P1' ~ Main::newline())); return($s) }} 
;
class Var { has $.sigil; has $.twigil; has $.name; method emit { do { [] }; (($.twigil eq '.') ?? ('  $P0 = getattribute self, \'' ~ ($.name ~ ('\'' ~ Main::newline()))) !! ('  $P0 = ' ~ (self.full_name() ~ (' ' ~ Main::newline())))) }; method name { do { [] }; $.name }; method full_name { do { [] }; my  $table = { '$' => 'scalar_','@' => 'list_','%' => 'hash_','&' => 'code_', }; (($.twigil eq '.') ?? $.name !! (($.name eq '/') ?? ($table.{$.sigil} ~ 'MATCH') !! ($table.{$.sigil} ~ $.name))) }} 
;
class Bind { has $.parameters; has $.arguments; method emit { do { [] }; do { if ($.parameters.isa('Lit::Array')) { my  $a = $.parameters.array();my  $b = $.arguments.array();my  $str = '';my  $i = 0;do { for ( @($a) ) -> $var { my  $bind = Bind.new( 'parameters' => $var,'arguments' => $b.[$i], );$str = ($str ~ $bind.emit());$i = ($i + 1) } };return(($str ~ $.parameters.emit())) } else {  } }; do { if ($.parameters.isa('Lit::Hash')) { my  $a = $.parameters.hash();my  $b = $.arguments.hash();my  $str = '';my  $i = 0;my  $arg;do { for ( @($a) ) -> $var { $arg = Val::Undef.new(  );do { for ( @($b) ) -> $var2 { do { if (($var2.[0].buf() eq $var.[0].buf())) { $arg = $var2.[1] } else {  } } } };my  $bind = Bind.new( 'parameters' => $var.[1],'arguments' => $arg, );$str = ($str ~ $bind.emit());$i = ($i + 1) } };return(($str ~ $.parameters.emit())) } else {  } }; do { if ($.parameters.isa('Lit::Object')) { my  $class = $.parameters.class();my  $a = $.parameters.fields();my  $b = $.arguments;my  $str = '';do { for ( @($a) ) -> $var { my  $bind = Bind.new( 'parameters' => $var.[1],'arguments' => Call.new( 'invocant' => $b,'method' => $var.[0].buf(),'arguments' => [],'hyper' => 0, ), );$str = ($str ~ $bind.emit()) } };return(($str ~ $.parameters.emit())) } else {  } }; do { if ($.parameters.isa('Var')) { return(($.arguments.emit() ~ ('  ' ~ ($.parameters.full_name() ~ (' = $P0' ~ Main::newline()))))) } else {  } }; do { if ($.parameters.isa('Decl')) { return(($.arguments.emit() ~ ('  .local pmc ' ~ ($.parameters.var().full_name() ~ (Main::newline() ~ ('  ' ~ ($.parameters.var().full_name() ~ (' = $P0' ~ (Main::newline() ~ ('  .lex \'' ~ ($.parameters.var().full_name() ~ ('\', $P0' ~ Main::newline())))))))))))) } else {  } }; do { if ($.parameters.isa('Lookup')) { my  $param = $.parameters;my  $obj = $param.obj();my  $index = $param.index();return(($.arguments.emit() ~ ('  save $P2' ~ (Main::newline() ~ ('  $P2 = $P0' ~ (Main::newline() ~ ('  save $P1' ~ (Main::newline() ~ ($obj.emit() ~ ('  $P1 = $P0' ~ (Main::newline() ~ ($index.emit() ~ ('  $P1[$P0] = $P2' ~ (Main::newline() ~ ('  restore $P1' ~ (Main::newline() ~ ('  restore $P2' ~ Main::newline()))))))))))))))))) } else {  } }; do { if ($.parameters.isa('Index')) { my  $param = $.parameters;my  $obj = $param.obj();my  $index = $param.index();return(($.arguments.emit() ~ ('  save $P2' ~ (Main::newline() ~ ('  $P2 = $P0' ~ (Main::newline() ~ ('  save $P1' ~ (Main::newline() ~ ($obj.emit() ~ ('  $P1 = $P0' ~ (Main::newline() ~ ($index.emit() ~ ('  $P1[$P0] = $P2' ~ (Main::newline() ~ ('  restore $P1' ~ (Main::newline() ~ ('  restore $P2' ~ Main::newline()))))))))))))))))) } else {  } }; die(('Not implemented binding: ' ~ ($.parameters ~ (Main::newline() ~ $.parameters.emit())))) }} 
;
class Proto { has $.name; method emit { do { [] }; ('  $P0 = ' ~ ($.name ~ Main::newline())) }} 
;
class Call { has $.invocant; has $.hyper; has $.method; has $.arguments; method emit { do { [] }; do { if ((($.method eq 'perl') || (($.method eq 'yaml') || (($.method eq 'say') || ($.method eq 'join'))))) { do { if ($.hyper) { return(('[ map { Main::' ~ ($.method ~ ('( $_, ' ~ (', ' ~ (@.arguments>>.emit().join('') ~ (')' ~ (' } @{ ' ~ ($.invocant.emit() ~ ' } ]'))))))))) } else { return(('Main::' ~ ($.method ~ ('(' ~ ($.invocant.emit() ~ (', ' ~ (@.arguments>>.emit().join('') ~ ')'))))))) } } } else {  } }; my  $meth = $.method; do { if (($meth eq 'postcircumfix:<( )>')) { $meth = '' } else {  } }; my  $call = ('->' ~ ($meth ~ ('(' ~ (@.arguments>>.emit().join('') ~ ')')))); do { if ($.hyper) { return(('[ map { $_' ~ ($call ~ (' } @{ ' ~ ($.invocant.emit() ~ ' } ]'))))) } else {  } }; my  @args = @.arguments; my  $str = ''; my  $ii = 10; do { for ( @(@args) ) -> $arg { $str = ($str ~ ('  save $P' ~ ($ii ~ Main::newline())));$ii = ($ii + 1) } }; my  $i = 10; do { for ( @(@args) ) -> $arg { $str = ($str ~ ($arg.emit() ~ ('  $P' ~ ($i ~ (' = $P0' ~ Main::newline())))));$i = ($i + 1) } }; $str = ($str ~ ($.invocant.emit() ~ ('  $P0 = $P0.' ~ ($meth ~ '(')))); $i = 0; my  @p; do { for ( @(@args) ) -> $arg { @p.[$i] = ('$P' ~ ($i + 10));$i = ($i + 1) } }; $str = ($str ~ (@p.join(', ') ~ (')' ~ Main::newline()))); do { for ( @(@args) ) -> $arg { $ii = ($ii - 1);$str = ($str ~ ('  restore $P' ~ ($ii ~ Main::newline()))) } }; return($str) }} 
;
class Apply { has $.code; has $.arguments; my  $label = 100; method emit { do { [] }; my  $code = $.code; do { if (($code eq 'die')) { return(('  $P0 = new .Exception' ~ (Main::newline() ~ ('  $P0[' ~ (Main::quote() ~ ('_message' ~ (Main::quote() ~ ('] = ' ~ (Main::quote() ~ ('something broke' ~ (Main::quote() ~ (Main::newline() ~ ('  throw $P0' ~ Main::newline()))))))))))))) } else {  } }; do { if (($code eq 'say')) { return((@.arguments>>.emit().join(('  print $P0' ~ Main::newline())) ~ ('  print $P0' ~ (Main::newline() ~ ('  print ' ~ (Main::quote() ~ ('\\' ~ ('n' ~ (Main::quote() ~ Main::newline()))))))))) } else {  } }; do { if (($code eq 'print')) { return((@.arguments>>.emit().join(('  print $P0' ~ Main::newline())) ~ ('  print $P0' ~ Main::newline()))) } else {  } }; do { if (($code eq 'array')) { return(('  # TODO - array() is no-op' ~ Main::newline())) } else {  } }; do { if (($code eq 'prefix:<~>')) { return((@.arguments.[0].emit() ~ ('  $S0 = $P0' ~ (Main::newline() ~ ('  $P0 = $S0' ~ Main::newline()))))) } else {  } }; do { if (($code eq 'prefix:<!>')) { return(If.new( 'cond' => @.arguments.[0],'body' => [Val::Bit.new( 'bit' => 0, )],'otherwise' => [Val::Bit.new( 'bit' => 1, )], ).emit()) } else {  } }; do { if (($code eq 'prefix:<?>')) { return(If.new( 'cond' => @.arguments.[0],'body' => [Val::Bit.new( 'bit' => 1, )],'otherwise' => [Val::Bit.new( 'bit' => 0, )], ).emit()) } else {  } }; do { if (($code eq 'prefix:<$>')) { return(('  # TODO - prefix:<$> is no-op' ~ Main::newline())) } else {  } }; do { if (($code eq 'prefix:<@>')) { return(('  # TODO - prefix:<@> is no-op' ~ Main::newline())) } else {  } }; do { if (($code eq 'prefix:<%>')) { return(('  # TODO - prefix:<%> is no-op' ~ Main::newline())) } else {  } }; do { if (($code eq 'infix:<~>')) { return((@.arguments.[0].emit() ~ ('  $S0 = $P0' ~ (Main::newline() ~ ('  save $S0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  $S1 = $P0' ~ (Main::newline() ~ ('  restore $S0' ~ (Main::newline() ~ ('  $S0 = concat $S0, $S1' ~ (Main::newline() ~ ('  $P0 = $S0' ~ Main::newline())))))))))))))) } else {  } }; do { if (($code eq 'infix:<+>')) { return(('  save $P1' ~ (Main::newline() ~ (@.arguments.[0].emit() ~ ('  $P1 = $P0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  $P0 = $P1 + $P0' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))))))))) } else {  } }; do { if (($code eq 'infix:<->')) { return(('  save $P1' ~ (Main::newline() ~ (@.arguments.[0].emit() ~ ('  $P1 = $P0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  $P0 = $P1 - $P0' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))))))))) } else {  } }; do { if (($code eq 'infix:<&&>')) { return(If.new( 'cond' => @.arguments.[0],'body' => [@.arguments.[1]],'otherwise' => [], ).emit()) } else {  } }; do { if (($code eq 'infix:<||>')) { return(If.new( 'cond' => @.arguments.[0],'body' => [],'otherwise' => [@.arguments.[1]], ).emit()) } else {  } }; do { if (($code eq 'infix:<eq>')) { $label = ($label + 1);my  $id = $label;return((@.arguments.[0].emit() ~ ('  $S0 = $P0' ~ (Main::newline() ~ ('  save $S0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  $S1 = $P0' ~ (Main::newline() ~ ('  restore $S0' ~ (Main::newline() ~ ('  if $S0 == $S1 goto eq' ~ ($id ~ (Main::newline() ~ ('  $P0 = 0' ~ (Main::newline() ~ ('  goto eq_end' ~ ($id ~ (Main::newline() ~ ('eq' ~ ($id ~ (':' ~ (Main::newline() ~ ('  $P0 = 1' ~ (Main::newline() ~ ('eq_end' ~ ($id ~ (':' ~ Main::newline())))))))))))))))))))))))))))) } else {  } }; do { if (($code eq 'infix:<ne>')) { $label = ($label + 1);my  $id = $label;return((@.arguments.[0].emit() ~ ('  $S0 = $P0' ~ (Main::newline() ~ ('  save $S0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  $S1 = $P0' ~ (Main::newline() ~ ('  restore $S0' ~ (Main::newline() ~ ('  if $S0 == $S1 goto eq' ~ ($id ~ (Main::newline() ~ ('  $P0 = 1' ~ (Main::newline() ~ ('  goto eq_end' ~ ($id ~ (Main::newline() ~ ('eq' ~ ($id ~ (':' ~ (Main::newline() ~ ('  $P0 = 0' ~ (Main::newline() ~ ('eq_end' ~ ($id ~ (':' ~ Main::newline())))))))))))))))))))))))))))) } else {  } }; do { if (($code eq 'infix:<==>')) { $label = ($label + 1);my  $id = $label;return(('  save $P1' ~ (Main::newline() ~ (@.arguments.[0].emit() ~ ('  $P1 = $P0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  if $P0 == $P1 goto eq' ~ ($id ~ (Main::newline() ~ ('  $P0 = 0' ~ (Main::newline() ~ ('  goto eq_end' ~ ($id ~ (Main::newline() ~ ('eq' ~ ($id ~ (':' ~ (Main::newline() ~ ('  $P0 = 1' ~ (Main::newline() ~ ('eq_end' ~ ($id ~ (':' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))))))))))))))))))))))))) } else {  } }; do { if (($code eq 'infix:<!=>')) { $label = ($label + 1);my  $id = $label;return(('  save $P1' ~ (Main::newline() ~ (@.arguments.[0].emit() ~ ('  $P1 = $P0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  if $P0 == $P1 goto eq' ~ ($id ~ (Main::newline() ~ ('  $P0 = 1' ~ (Main::newline() ~ ('  goto eq_end' ~ ($id ~ (Main::newline() ~ ('eq' ~ ($id ~ (':' ~ (Main::newline() ~ ('  $P0 = 0' ~ (Main::newline() ~ ('eq_end' ~ ($id ~ (':' ~ (Main::newline() ~ ('  restore $P1' ~ Main::newline())))))))))))))))))))))))))) } else {  } }; do { if (($code eq 'ternary:<?? !!>')) { return(If.new( 'cond' => @.arguments.[0],'body' => [@.arguments.[1]],'otherwise' => [@.arguments.[2]], ).emit()) } else {  } }; do { if (($code eq 'defined')) { return((@.arguments.[0].emit() ~ ('  $I0 = defined $P0' ~ (Main::newline() ~ ('  $P0 = $I0' ~ Main::newline()))))) } else {  } }; do { if (($code eq 'substr')) { return((@.arguments.[0].emit() ~ ('  $S0 = $P0' ~ (Main::newline() ~ ('  save $S0' ~ (Main::newline() ~ (@.arguments.[1].emit() ~ ('  $I0 = $P0' ~ (Main::newline() ~ ('  save $I0' ~ (Main::newline() ~ (@.arguments.[2].emit() ~ ('  $I1 = $P0' ~ (Main::newline() ~ ('  restore $I0' ~ (Main::newline() ~ ('  restore $S0' ~ (Main::newline() ~ ('  $S0 = substr $S0, $I0, $I1' ~ (Main::newline() ~ ('  $P0 = $S0' ~ Main::newline()))))))))))))))))))))) } else {  } }; my  @args = @.arguments; my  $str = ''; my  $ii = 10; my  $arg; do { for ( @(@args) ) -> $arg { $str = ($str ~ ('  save $P' ~ ($ii ~ Main::newline())));$ii = ($ii + 1) } }; my  $i = 10; do { for ( @(@args) ) -> $arg { $str = ($str ~ ($arg.emit() ~ ('  $P' ~ ($i ~ (' = $P0' ~ Main::newline())))));$i = ($i + 1) } }; $str = ($str ~ ('  $P0 = ' ~ ($.code ~ '('))); $i = 0; my  @p; do { for ( @(@args) ) -> $arg { @p.[$i] = ('$P' ~ ($i + 10));$i = ($i + 1) } }; $str = ($str ~ (@p.join(', ') ~ (')' ~ Main::newline()))); do { for ( @(@args) ) -> $arg { $ii = ($ii - 1);$str = ($str ~ ('  restore $P' ~ ($ii ~ Main::newline()))) } }; return($str) }} 
;
class Return { has $.result; method emit { do { [] }; ($.result.emit() ~ ('  .return( $P0 )' ~ Main::newline())) }} 
;
class If { has $.cond; has $.body; has $.otherwise; my  $label = 100; method emit { do { [] }; $label = ($label + 1); my  $id = $label; return(($.cond.emit() ~ ('  unless $P0 goto ifelse' ~ ($id ~ (Main::newline() ~ (@.body>>.emit().join('') ~ ('  goto ifend' ~ ($id ~ (Main::newline() ~ ('ifelse' ~ ($id ~ (':' ~ (Main::newline() ~ (@.otherwise>>.emit().join('') ~ ('ifend' ~ ($id ~ (':' ~ Main::newline()))))))))))))))))) }} 
;
class For { has $.cond; has $.body; has $.topic; my  $label = 100; method emit { do { [] }; my  $cond = $.cond; $label = ($label + 1); my  $id = $label; do { if (($cond.isa('Var') && ($cond.sigil() ne '@'))) { $cond = Lit::Array.new( 'array' => [$cond], ) } else {  } }; return(('' ~ ($cond.emit() ~ ('  save $P1' ~ (Main::newline() ~ ('  save $P2' ~ (Main::newline() ~ ('  $P1 = new .Iterator, $P0' ~ (Main::newline() ~ (' test_iter' ~ ($id ~ (':' ~ (Main::newline() ~ ('  unless $P1 goto iter_done' ~ ($id ~ (Main::newline() ~ ('  $P2 = shift $P1' ~ (Main::newline() ~ ('  store_lex \'' ~ ($.topic.full_name() ~ ('\', $P2' ~ (Main::newline() ~ (@.body>>.emit().join('') ~ ('  goto test_iter' ~ ($id ~ (Main::newline() ~ (' iter_done' ~ ($id ~ (':' ~ (Main::newline() ~ ('  restore $P2' ~ (Main::newline() ~ ('  restore $P1' ~ (Main::newline() ~ '')))))))))))))))))))))))))))))))))) }} 
;
class Decl { has $.decl; has $.type; has $.var; method emit { do { [] }; my  $decl = $.decl; my  $name = $.var.name(); (($decl eq 'has') ?? ('  addattribute self, ' ~ (Main::quote() ~ ($name ~ (Main::quote() ~ Main::newline())))) !! ('  .local pmc ' ~ ($.var.full_name() ~ (' ' ~ (Main::newline() ~ ('  .lex \'' ~ ($.var.full_name() ~ ('\', ' ~ ($.var.full_name() ~ (' ' ~ Main::newline())))))))))) }} 
;
class Sig { has $.invocant; has $.positional; has $.named; method emit { do { [] }; ' print \'Signature - TODO\'; die \'Signature - TODO\'; ' }; method invocant { do { [] }; $.invocant }; method positional { do { [] }; $.positional }} 
;
class Method { has $.name; has $.sig; has $.block; method emit { do { [] }; my  $sig = $.sig; my  $invocant = $sig.invocant(); my  $pos = $sig.positional(); my  $str = ''; my  $i = 0; my  $field; do { for ( @($pos) ) -> $field { $str = ($str ~ ('  $P0 = params[' ~ ($i ~ (']' ~ (Main::newline() ~ ('  .lex \'' ~ ($field.full_name() ~ ('\', $P0' ~ Main::newline()))))))));$i = ($i + 1) } }; return(('.sub ' ~ (Main::quote() ~ ($.name ~ (Main::quote() ~ (' :method :outer(' ~ (Main::quote() ~ ('_class_vars_' ~ (Main::quote() ~ (')' ~ (Main::newline() ~ ('  .param pmc params  :slurpy' ~ (Main::newline() ~ ('  .lex \'' ~ ($invocant.full_name() ~ ('\', self' ~ (Main::newline() ~ ($str ~ (@.block>>.emit().join('') ~ ('.end' ~ (Main::newline() ~ Main::newline()))))))))))))))))))))) }} 
;
class Sub { has $.name; has $.sig; has $.block; method emit { do { [] }; my  $sig = $.sig; my  $invocant = $sig.invocant(); my  $pos = $sig.positional(); my  $str = ''; my  $i = 0; my  $field; do { for ( @($pos) ) -> $field { $str = ($str ~ ('  $P0 = params[' ~ ($i ~ (']' ~ (Main::newline() ~ ('  .lex \'' ~ ($field.full_name() ~ ('\', $P0' ~ Main::newline()))))))));$i = ($i + 1) } }; return(('.sub ' ~ (Main::quote() ~ ($.name ~ (Main::quote() ~ (' :outer(' ~ (Main::quote() ~ ('_class_vars_' ~ (Main::quote() ~ (')' ~ (Main::newline() ~ ('  .param pmc params  :slurpy' ~ (Main::newline() ~ ($str ~ (@.block>>.emit().join('') ~ ('.end' ~ (Main::newline() ~ Main::newline()))))))))))))))))) }} 
;
class Do { has $.block; method emit { do { [] }; @.block>>.emit().join('') }} 
;
class Use { has $.mod; method emit { do { [] }; ('  .include ' ~ (Main::quote() ~ ($.mod ~ (Main::quote() ~ Main::newline())))) }} 
;
