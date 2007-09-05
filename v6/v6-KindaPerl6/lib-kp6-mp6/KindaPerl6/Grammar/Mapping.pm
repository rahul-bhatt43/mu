
use v6-alpha;

grammar KindaPerl6::Grammar {

token key { 
    |  <ident> <before <'=>'> | <?ws> > 
       { return ::Val::Buf( 'buf' => ~$<ident> ) }  # autoquote
    |  <exp>   
       { return $$<exp> } 
};

token pair {
    |   <key> 
        <?opt_ws> <'=>'> <?opt_ws>
        <exp>
        { return [ $$<key>, $$<exp> ] }
    |   \: <sigil> <ident>                  #  :$var
        { 
            return [ 
                ::Val::Buf( 'buf' => ~$<ident> ), 
                ::Var( 'sigil' => ~$$<sigil>, 'twigil' => '', 'name' => $$<ident> ) ] 
        } 
};

token exp_mapping {
    |   <pair> 
        [
        |   <?opt_ws> \, <?opt_ws> <exp_mapping> 
            { return [ $$<pair>, @( $$<exp_mapping> ) ] }
        |   <?opt_ws> [ \, <?opt_ws> | <''> ]
            { return [ $$<pair> ] }
        ]
    |
        { return [ ] }
};

token exp_parameter_list {
    |   <pair> 
        [
        |   <?opt_ws> \, <?opt_ws> <exp_parameter_list> 
            { return [ $$<pair>, @( $$<exp_parameter_list> ) ] }
        |   <?opt_ws> [ \, <?opt_ws> | <''> ]
            { return [ $$<pair> ] }
        ]
    |   <exp> 
        [
        |   <?opt_ws> \, <?opt_ws> <exp_parameter_list> 
            { return [ $$<exp>, @( $$<exp_parameter_list> ) ] }
        |   <?opt_ws> [ \, <?opt_ws> | <''> ]
            { return [ $$<exp> ] }
        ]
    |
        { return [ ] }
};

}

