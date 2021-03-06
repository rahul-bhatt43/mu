# pX/Common/p6rule.t - fglock

use strict;
use warnings;

use Runtime::Perl5::RuleOps;

use Test::More qw(no_plan);
use Data::Dumper;
$Data::Dumper::Indent = 1;
$Data::Dumper::Pad = '# ';
my ( $rule, $match );

{
  $rule = 
    Runtime::Perl5::RuleOps::non_greedy_plus( 
      Runtime::Perl5::RuleOps::alternation( [
        Runtime::Perl5::RuleOps::constant( 'a' ), 
        Runtime::Perl5::RuleOps::constant( 'c' ), 
      ] ),
    );
  $match = $rule->( 'a123', undef, {capture=>1} );
  ok ( $match->{bool}, "/[a|c]/ #1" );
  is ( $match->{tail}, '123', "tail is ok" );
  $match = $rule->( 'c123', undef, {capture=>1} );
  ok ( $match->{bool}, "/[a|c]/ #2" );
  is ( $match->{tail}, '123', "tail is ok" );
  #print Dumper( $match );
}

{
  $rule = 
    Runtime::Perl5::RuleOps::greedy_star( 
      Runtime::Perl5::RuleOps::constant( 'a' ) 
    );
  is ( ref $rule, "CODE", "rule 'a*' is a coderef" );
  $match = $rule->( 'aa' );
  # print Dumper( $match );
  ok ( $match->{bool}, "/a*/" );
  #print Dumper( $match );
  $match = $rule->( '' );
  ok ( $match->{bool}, "matches 0 occurrences" );
  #print Dumper( $match );
}

{
  $rule = 
    Runtime::Perl5::RuleOps::greedy_plus( 
      Runtime::Perl5::RuleOps::constant( 'a' ) 
    );
  $match = $rule->( 'aa' );
  ok ( $match->{bool}, "/a+/" );
  $match = $rule->( '!!' );
  ok ( ! $match->{bool}, "rejects unmatching text" );
}

{
  $rule = 
    Runtime::Perl5::RuleOps::concat(
      Runtime::Perl5::RuleOps::greedy_plus( 
        Runtime::Perl5::RuleOps::alternation( [
          Runtime::Perl5::RuleOps::constant( 'a' ), 
          Runtime::Perl5::RuleOps::constant( 'c' ), 
        ] ),
      ),
      Runtime::Perl5::RuleOps::constant( 'ab' )
    );
  $match = $rule->( 'aacaab' );
  ok ( $match->{bool}, "/[a|c]+ab/ with backtracking" );
  # print Dumper( $match );
}

print "# XXX other tests disabled due to a big API change\n";
__END__

{
  $rule = 
    Runtime::Perl5::RuleOps::non_greedy_plus( 
      Runtime::Perl5::RuleOps::alternation( [
        Runtime::Perl5::RuleOps::constant( 'a' ), 
        Runtime::Perl5::RuleOps::constant( 'c' ), 
      ] ),
    );
  ( $stat, $assertion, $match, $tail ) = $rule->( 'aacaab', undef, {capture=>1} );
  ok ( defined $match, "/[a|c]+/" );
  is ( $tail, 'acaab', "tail is ok" );
  #print Dumper( $match );
}

{
  $rule = 
    Runtime::Perl5::RuleOps::concat(
      Runtime::Perl5::RuleOps::non_greedy_plus( 
        Runtime::Perl5::RuleOps::alternation( [
          Runtime::Perl5::RuleOps::constant( 'a' ), 
          Runtime::Perl5::RuleOps::constant( 'c' ), 
        ] ),
      ),
      Runtime::Perl5::RuleOps::constant( 'cb' )
    );
  ( $stat, $assertion, $match, $tail ) = $rule->( 'aacacb' );
  ok ( defined $match, "/[a|c]+?ab/ with backtracking" );
  #print Dumper( $match );
}

{
  # tests for a problem found in the '|' implementation in p6rule parser
  
  my $rule = 
    Runtime::Perl5::RuleOps::constant( 'a' );
  my $alt = 
    Runtime::Perl5::RuleOps::concat(
        $rule,
        Runtime::Perl5::RuleOps::optional (
            Runtime::Perl5::RuleOps::concat(
                Runtime::Perl5::RuleOps::constant( '|' ),
                $rule
            )
        )
    );
  ( $stat, $assertion, $match, $tail ) = $alt->( 'a' );
  ok ( defined $match, "/a|a/ #1" );
  ( $stat, $assertion, $match, $tail ) = $alt->( 'a|a' );
  ok ( defined $match, "/a|a/ #2" );

  # adding '*' caused a deep recursion error (fixed)

  $alt = 
    Runtime::Perl5::RuleOps::concat(
        $rule,
        Runtime::Perl5::RuleOps::greedy_star(
          Runtime::Perl5::RuleOps::concat(
              Runtime::Perl5::RuleOps::constant( '|' ),
              $rule
          )
        )
    );
  ( $stat, $assertion, $match, $tail ) = $alt->( 'a' );
  ok ( defined $match, "/a [ |a ]*/ #1" );
  ( $stat, $assertion, $match, $tail ) = $alt->( 'a|a' );
  ok ( defined $match, "/a [ |a ]*/ #2" );
  ( $stat, $assertion, $match, $tail ) = $alt->( 'a|a|a' );
  ok ( defined $match, "/a [ |a ]*/ #3" );

}

__END__

# old tests 

print "word\n", Dumper( 
  &{'rule::<word>'}( 0, qw(b a a ! !) ) 
);
print "word concat\n", Dumper( 
  rule::concat( \&{'rule::<word>'}, \&{'rule::<ws>'} )->( 0, qw(b a ),' ' ) 
);
print "non_greedy + backtracking\n", Dumper( 
  rule::concat(
    rule::non_greedy( rule::constant('a') ),
    rule::constant('ab')
  )->( 0, qw(a a a a b) ) 
);
print "alternation + backtracking\n", Dumper( 
  rule::concat(
    rule::alternation( rule::constant('a'), rule::constant('ab') ),
    rule::constant('ab')
  )->( 0, qw(a b a b) ) 
);
print "alternation + greedy + backtracking -- (ab,a,ab)(ab)\n", Dumper( 
  rule::concat(
    rule::greedy(
      rule::alternation( rule::constant('a'), rule::constant('ab') )
    ),
    rule::constant('ab')
  )->( 0, qw(a b a a b a b) ) 
);
