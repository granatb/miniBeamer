#!/usr/bin/perl

## Based on convert.txt by Mike Love
## https://gist.github.com/mikelove/5618f935ace6e389d3fbac03224860cd

## The script ignores labels and references, un-numbered sections
## (section*) and quotes.


use warnings;

my $filename = $ARGV[0];

open (RNW, $filename);
while (<RNW>) {
    s|\\begin\{(.+?)}|---|g;
    s|\\author\{(.+?)}|author: $1|g;
    s|\\title\{(.+?)}|title: $1|g;
    s|\\maketitle|---|g;
    
    s|\\Robject\{(.+?)}|`$1`|g;
    s|\\Rcode\{(.+?)}|`$1`|g;
    s|\\Rclass\{(.+?)}|*$1*|g;
    s|\\Rfunction\{(.+?)}|`$1`|g;

    
    s|\\texttt\{(.+?)}|`$1`|g;
    s|\\textit\{(.+?)}|*$1*|g;
    s|\\textbf\{(.+?)}|**$1**|g;
    s|\\emph\{(.+?)}|*$1*|g;
    s|<<|```\{r |g;
    s|>>=|}|g;
    s|@|```|g;
    s|\\section\{(.+?)}|# $1|g;
    s|\\subsection\{(.+?)}|## $1|g;
    s|\\subsubsection\{(.+?)}|### $1|g;
    s|\\Biocexptpkg\{(.+?)}|`r Biocexptpkg("$1")`|g;
    s|\\Biocannopkg\{(.+?)}|`r Biocannopkg("$1")`|g;
    s|\\Biocpkg\{(.+?)}|`r Biocpkg("$1")`|g;
    s|\\cite\{(.+?)}|[\@$1]|g;
    s|\\ref\{(.+?)}|\\\@ref($1)|g;
    s|\\url\{(.+?)}|<$1>|g;
    s|\\ldots|\.\.\.|g;
    s|\\label\{| {#|g; ## only for sections
    s|^(%+)*||g;
    s|^\\.+||g;
    s|^=+|<!-- -->\n|g;
    print $_;
}
close (RNW);