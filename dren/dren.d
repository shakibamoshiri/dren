import std.stdio:		writeln;
import std.file:		dirEntries, SpanMode;
import std.algorithm:	map, filter, each;
import std.regex:		regex, matchFirst, replaceFirst;
import std.array:		array, empty;
import std.file:		rename;

int main( string[] args ){
	
	if( args.length < 6 ){
		writeln( "--------------------------------------------------------------------------------" );
		writeln( "A rename program utility based on \033[1;32mregex\033[m in \033[1;31mD Language\033[m, and written by k-five   -" );
		writeln( "--------------------------------------------------------------------------------" );
		writeln( "Usage: [regex] [regex] [-f  or -d  or -a ] [-n  or -r ] [ -y  or -p ]          -" );
		writeln( "When:  first regex is for matching                                             -" );
		writeln( "When:  second regex is for substitution                                        -" );
		writeln( "When:  -f = only-file | -d = only-directory | -a = both-file-directory         -" );
		writeln( "When:  -n = non-recursive | -r = recursively                                   -" );
		writeln( "When:  -y = yes-rename the file | -p = no, only-print the output               -" );
		writeln( "--------------------------------------------------------------------------------" );
		writeln( "Ex: ", args[ 0 ], " 'htm' '$&l' -f -r -p = any files that match 'htm', recursively, print" );
		writeln( "--------------------------------------------------------------------------------" );
		writeln( "Thanks to Walter Bright, Andrei Alexandrescu, and forum.dlang.org.             -" );
		writeln( "Copyright (C) Shakiba.Moshiri 2017. License: Boost                             -" );
		writeln( "--------------------------------------------------------------------------------" );
		return 0;
	} else {
		if( ( args[ 3 ] == "-f" || args[ 3 ] == "-d" || args[ 3 ] == "-a" ) && ( args[ 4 ] == "-n" || args [ 4 ] == "-r" ) && ( args[ 5 ] == "-y" || args[ 5 ] == "-p" ) ){
		dirEntries( ".", ( args[ 4 ] == "-r" ? SpanMode.depth : SpanMode.shallow ), false )
			.filter!( file => !file.name.matchFirst( regex( args[ 1 ] ) ).empty() )
			.filter!( file => ( args[ 3 ] == "-f" || args[ 3 ] == "-d"  ? ( args[ 3 ] == "-f" ? !file.isDir : !file.isFile ) : ( !file.isSymlink ) ) )
			.map!( file => file.name )
			.each!( ( string result ) => ( args[ 5 ] == "-y" ? rename( result, replaceFirst( result, regex( args[ 1 ] ), args[ 2 ] ) ) : writeln( "print: ",result, " >> ", replaceFirst( result, regex( args[ 1 ] ), "\033[1;32m" ~ args[ 2 ] ~ "\033[m" ) ) ) );
		} else {
			writeln( "Usage: [regex] [regex] [-f  or -d  or -a ] [-n  or -r ] [ -y  or -p ]" );
		}
			
	}
	return 0;
}

