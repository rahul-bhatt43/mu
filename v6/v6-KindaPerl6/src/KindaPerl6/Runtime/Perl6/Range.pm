use v6-alpha;
class Range is Value {
    has $.start;
    has $.end;
    method perl {
        '( ' ~ $.start.perl ~ '..' ~ $.end.perl ~ ' )' 
    };
    method Str {
        $.start ~ ".." ~ $.end 
    };
    #method true { true };
    #method Int  { $.start.Int };
    #method hash {
    #    { $.start => $.end, }
    #};
    #method array {
    #    [ $.start, $.end ]
    #};
    method for ( &code ) {
        my $arity = (&code.signature).arity;
        my $i = 0;
        my $v = $.start;
        while $v <= $.end {
            my @param;
            while @param.elems < $arity {
                @param.push( ( $v <= $.end ) ?? $v !! undef );
                $v = $v + 1;
            }
            code( |@param );
        };
    };
}
