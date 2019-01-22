eval 'exec perl -wS $0 ${1+"$@"}' # -*- perl -*-
    if 0;

use strict;
use Getopt::Long;
use File::Find;
use File::Basename;
use Cwd;
use File::Path;
use File::Copy;
use File::stat;

my $dir_opt=();
my $help_opt=();

GetOptions(
    "d|dir=s",      => \$dir_opt,
    "h|help!",      => \$help_opt
);

if($help_opt ne ""){
   &print_help();
   exit;
}

my @all_dirs=();
my @a_class=();
my @all_tcs=();

my $dir_single;

if($dir_opt ne ""){
   if(-d $dir_opt){
      my $orig_dir = `pwd`;
      chomp($orig_dir);
      search_all_relevant_dir($dir_opt);

      system("rm -rf run.log");
      foreach $dir_single(@all_dirs){
         chdir($dir_single);
         if(-e "run"){
            print "run at: $dir_single \n";
            system("pwd >> $orig_dir/run.log");
            system("./run >> $orig_dir/run.log");
         }
         elsif (-e "run_tc"){
            print "run at: $dir_single \n";
            system("pwd >> $orig_dir/run.log");
            system("./run_tc my_case0 >> $orig_dir/run.log");
         }
         chdir($orig_dir);
      }
   }else{
      print "$dir_opt is not an valid directory\n";
   }
}else{
   print "ERROR::please specify an directory with -d option or specify an file with -f option !\n";
   exit;
}

sub search_all_relevant_dir{
	my ($dir) = @_;
	finddepth({ wanted => \&dir_pattern, no_chdir => 1 }, $dir);
}

sub dir_pattern {
	my($filename)= $File::Find::name;
	my($st) =stat($filename) || die "error: $filename: $!";

	
# NOTE files are not handled (a directory ovm_bla has to be renamed manually)
	return 0 if (-f $filename);
	warn("file $filename is a link and may lead to strange results") if -l $filename;
#	return 0 if $filename =~ /${file_ignore_pattern}/;
#	return unless $filename =~ /\.s?vh?$/;

#	replace_string($filename);
	push @all_dirs,$filename;
}

sub print_help {
    print "please run the script file with following options:\n";
    print "-d directory_name: run simulation at directory_name\n";
}
