#! e:/program files/perl/bin/perl.exe
#  version info can be found in 'configure.ac'

require "../local-paths.lib";

$pangomm_version = "2.34.0";
$major = 2;
$minor = 34;
$micro = 0;
$binary_age = 3400;
$interface_age = 0;
$current_minus_age = 0;
$exec_prefix = "lib";

sub process_file
{
        my $outfilename = shift;
	my $infilename = $outfilename . ".in";
	
	open (INPUT, "< $infilename") || exit 1;
	open (OUTPUT, "> $outfilename") || exit 1;
	
	while (<INPUT>) {
	    s/\@PACKAGE_VERSION@/$pangomm_version/g;
	    s/\@PANGO_API_VERSION@/$pango_api_version/g;
	    s/\@GLIB_API_VERSION@/$glib_api_version/g;
	    s/\@PANGOMM_MAJOR_VERSION\@/$major/g;
	    s/\@PANGOMM_MINOR_VERSION\@/$minor/g;
	    s/\@PANGOMM_MICRO_VERSION\@/$micro/g;
	    s/\@PANGOMM_INTERFACE_AGE\@/$interface_age/g;
	    s/\@PANGOMM_BINARY_AGE\@/$binary_age/g;
	    s/\@LT_CURRENT_MINUS_AGE@/$current_minus_age/g;
	    s/\@PANGOMM_MODULE_NAME@/$pangomm_module_name/g;
	    s/\@PERL@/$perl_path/g;
	    s/\@prefix@/$exec_prefix/g;
	    s/\@exec_prefix@/$exec_prefix/g;
	    s/\@M4@/$m4_path/g;
	    s/\@libdir@/$generic_library_folder/g;
	    s/\@GlibBuildRootFolder@/$glib_build_root_folder/g;
	    s/\@GlibmmBuildRootFolder@/$glibmm_build_root_folder/g;
	    s/\@GtkmmBuildRootFolder@/$gtkmm_build_root_folder/g;
	    s/\@AtkmmBuildRootFolder@/$atkmm_build_root_folder/g;
	    s/\@PangommBuildRootFolder@/$pangomm_build_root_folder/g;
	    s/\@GenericIncludeFolder@/$generic_include_folder/g;
	    s/\@GenericLibraryFolder@/$generic_library_folder/g;
	    s/\@GenericWin32LibraryFolder@/$generic_win32_library_folder/g;
	    s/\@GenericWin32BinaryFolder@/$generic_win32_binary_folder/g;
	    s/\@Debug32TestSuiteFolder@/$debug32_testsuite_folder/g;
	    s/\@Release32TestSuiteFolder@/$release32_testsuite_folder/g;
	    s/\@Debug32TargetFolder@/$debug32_target_folder/g;
	    s/\@Release32TargetFolder@/$release32_target_folder/g;
	    s/\@TargetSxSFolder@/$target_sxs_folder/g;
	    s/\@includedir@/$generic_include_folder/g;
	    s/\@PANGOMM_API_VERSION\@/$api_version/g;
	    print OUTPUT;
	}
}

if (-1 != index($command, "-X64")) {
	$pangomm_module_name = "libpangomm64-2.0";
	$api_version = "64-2.0-0";
} else {
	$pangomm_module_name = "libpangomm32-2.0";
	$api_version = "32-2.0-0";
}

process_file ("pango/pangommconfig.h");
process_file ("pango/pangomm.pc");

my $command=join(' ',@ARGV);
if ($command eq -buildall) {
	process_file ("build/msvc/pangomm.vsprops");
	process_file ("pango/pangomm.rc");
}