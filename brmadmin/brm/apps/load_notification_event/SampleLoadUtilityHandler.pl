#!/apps/brm/ThirdParty/perl/5.8.0/bin/perl
# 
# $Header: bus_platform_vob/batch_scheduler/SampleHandler/SampleLoadUtilityHandler.pl /cgbubrm_7.3.2.portalbase/1 2008/10/06 01:05:08 vsangram Exp $
#
# SampleLoadutilityHandler.pl
# 
# Copyright (c) 2008, Oracle and/or its affiliates. All rights reserved.
#
#    NAME
#      SampleLoadutilityHandler.pl - <one-line expansion of the name>
#
#    DESCRIPTION
#      <short description of component this file declares/defines>
#
#    NOTES
#      <other useful comments, qualifications, etc.>
#
#    MODIFIED   (MM/DD/YY)
#    vsangram    09/14/08 - BATCH HANDLER FOR CREDIT CONTROL LOAD UTILITY#bug7395303
# 

require "SampleLoadUtilityHandler_config.values";
require "getopts.pl";
use pcmif;
use Sys::Hostname;
use File::Copy;
use File::Basename;
use File::Path;


#
# Define the Sample Handler status variables that return
# to the database.
$HANDLER_STARTED = 1;			# Handler started properly.
$COMPLETED_NO_ERROR = 19;		# The file was processed by the batch
                                        # application with no error.
$DEAD_STATUS = 100;			# Status of a previously failed handler.
$WITH_ERROR = 101;			# The file was processed by the batch
                                        # application with error.
$REJECTED = 102;			# The file was rejected by the batch
                                        # application.
$PILOT_ERROR = 103;			# Batch application failed with
                                        # pilot error.
$NO_FILE_TYPE = 104;			# File does not exist.
$FAIL_TO_MOVE_FILE = 105;		# Failed to move the file to the
                                        # processing directory.
$NO_LOADNOTIFY_EXEC = 106;		# Batch application executable does
                                        # not exit.
$FAIL_TO_START_LOADNOTIFY = 107;	# Failed to start batch application.

#
# Value to message negative batch application exit codes under Unix.
$UNIX_SHIFT = 8;


#
# Define the batch application exit code values.
$NO_ERROR = 0;


#
# Get the current time.
$localtime = localtime();


#
# Command line argument.
&Getopts('p:d:') || &usage;

if (!defined $opt_p) {
	&usage;
}
$current_poid = $opt_p;


#
# Check if there is a log file associated with the handler
open(LOG, ">>$LOGFILE");


#
# Get the current handler process id (PID)
$PID = $$;


#
# Log a debugging message in the handler log file
if ($DEBUG) {
	print LOG "Handler associated with '$current_poid' started\n";
	print LOG "at $localtime with PID = $PID.\n";
}


#
# setup and connect
my $db_no;
$ebufp = pcmif::pcm_perl_new_ebuf();
$pcm_ctxp = pcmif::pcm_perl_connect($db_no, $ebufp);
$DB_NO = $db_no;
if (pcmif::pcm_perl_is_err($ebufp)) {
	pcmif::pcm_perl_print_ebuf($ebufp);
	clean_exit(1);
} else {
	$my_session = pcmif::pcm_perl_get_session($pcm_ctxp);
	if ($DEBUG) {
		print LOG "$PID: Default DB is: $db_no\n";
		print LOG "$PID: Session poid is: ", $my_session, "\n";
	}
}


#
# Create the input Flist to update object status to STARTED.
$T_time = pcmif::pin_perl_time();
$hostname = hostname();
$f1 = << "END"
0 PIN_FLD_POID				     POID [0] $current_poid
0 PIN_FLD_START_T			   TSTAMP [0] ($T_time)
0 PIN_FLD_HOSTNAME			      STR [0] "$hostname"
0 PIN_FLD_PID				      INT [0] $$
0 PIN_FLD_STATUS			     ENUM [0] $HANDLER_STARTED
END
;


#
# Convert the flist string into an actual FList
$flistp = pcmif::pin_perl_str_to_flist($f1, $db_no, $ebufp);
if (pcmif::pcm_perl_is_err($ebufp)) {
	print LOG "$PID: Flist conversion failed:\n$f1\n";
	pcmif::pcm_perl_print_ebuf($ebufp);
	clean_exit(1);
}


#
# Call opcode to set status to STARTED.
$out_flistp = pcmif::pcm_perl_op($pcm_ctxp, "PCM_OP_WRITE_FLDS",
				     0, $flistp, $ebufp);


#
# If there is an error, log a message and die.
if (pcmif::pcm_perl_is_err($ebufp)) {
	print LOG "$PID: Failed to update handler object.\n";
	pcmif::pcm_perl_print_ebuf($ebufp);
	pcmif::pin_flist_destroy($flistp);
	pcmif::pin_flist_destroy($out_flistp);
	clean_exit(1);
}


#
# Upon success, destroy the input and return flists.
pcmif::pin_flist_destroy($flistp);
pcmif::pin_flist_destroy($out_flistp);


#
# Perform housekeeping tasks if the -d commandline option was used.
if (defined $opt_d) {
	$dead_poid = $opt_d;
	print LOG "$PID: Previously started handler associated with "
			. "$dead_poid has died.\n";

	#
	# Update the handler status of that handler's object to DEAD.
	$T_time = pcmif::pin_perl_time();
	$f1 = << "END"
	0 PIN_FLD_POID				     POID [0] $dead_poid
	0 PIN_FLD_END_T				   TSTAMP [0] ($T_time)
	0 PIN_FLD_STATUS			     ENUM [0] $DEAD_STATUS
END
;


	#
	# Convert the flist string into an actual FList
	$flistp = pcmif::pin_perl_str_to_flist($f1, $db_no, $ebufp);
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: Flist conversion failed:\n$f1\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		clean_exit(1);
	}


	#
	# Call the opcode PCM_OP_WRITE_FLDS to update status.
	$out_flistp = pcmif::pcm_perl_op($pcm_ctxp,
			"PCM_OP_WRITE_FLDS", 0, $flistp, $ebufp);

	#
	# If there is an error, print a message and die.
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: PCM_OP_WRITE_FLDS failed.\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		$out = pcmif::pin_perl_flist_to_str($out_flistp, $ebufp);
		clean_exit(1);
	}

	#
	# Destroy the input and return flists.
	pcmif::pin_flist_destroy($flistp);
	pcmif::pin_flist_destroy($out_flistp);
}


#
# Find input file associated with the handler.
#

#
# Get the list of files in the staging directory; skip all beginning with '.'
opendir STAGING_DIR, "$STAGING" or die "$PID: Cannot open directory $STAGING";
@allfiles = grep !/^$STAGING\/\./, map "$STAGING/$_", readdir(STAGING_DIR);
closedir(STAGING_DIR);

#
# Ensure the user is not passing the directory path name
# within the file type.
$FILETYPE = basename ($FILETYPE);

#
# Find files matching specified pattern in the staging dir.
$FILETYPE =~ s/\./\\\./g;
$FILETYPE =~ s/\*/\.*/g;
@file_type = grep /^$STAGING.$FILETYPE$/, @allfiles;
$numelements = @file_type;
if ($numelements <= 0) {
	print LOG "$PID: No files match specified pattern, exiting.\n";
	&HandlerDie($NO_FILE_TYPE, $current_poid);
}


#
# Sort matching files based on creation date.
foreach $file(@file_type){
	$age{$file} = -M$file;
}
@sorted_allfiles = sort byage @file_type;

#
# Reformat directory path name based on operating system type.
if ($loadutilDir =~ /\\/) {
	$loadutilDir =~ s/\\/\//g;
}

#
# Which operating system are we on?
if ($^O =~/win/i) {
	$loadutilDir =~ s/\//\\/g;
}

#
# Prepare input files for processing.
$moved_a_file = 0; # Set to 1 when a file is successfully moved.
foreach $file(@sorted_allfiles) {

	# Uncompress file if necessary,
	# reset variable to uncompressed file name.
	if ($file =~ /.Z$/) {
		# foo.Z -> foo
		system "uncompress $file";
		$file =~ s/\.Z$//;
	}
	if ($file =~ /.gz$/) {
		# foo.gz -> foo
		system "gunzip $file";
		$file =~ s/\.gz$//;
	}


	#
	# Move file from the staging directory to the processing directory.
	my $lock_File = $PROCESSING . "/" . basename($file) . ".lock";
	if( ! -e $lock_File) {
		open(LOCK,">$lock_File");
		flock(LOCK,LOCK_EX);
		$retval = &callTheMoveToProcessing($file);
		if (!$retval) {
			# The directory does not exist or some other error.
			&HandlerDie($FAIL_TO_MOVE_FILE, $current_poid);
		} elsif ($retval == -1) {
			#
			# If the move failed on a 'file not found' error, it means
			# another parallel handler took that file.  This handler
			# will try to get another file.
			next;
		}
		$moved_a_file = 1;
		if ($DEBUG) {
			print LOG "$PID: File $file moved to the "
				. "processing directory.\n";
		}
	}
	else{
		if ($DEBUG) {
		print LOG "$PID: File already processed by another batch handler. \n";
		}
		next;
	}

	#
	# Check to see if the batch executable exists.
	if (! -e $loadutil) {
		print LOG "$PID: Executable for batch application does "
			. "not exist\n";
		&HandlerDie($NO_LOADNOTIFY_EXEC, $current_poid);
	}

	#
	# Start the batch application.
	#

	#
	# Use the base filename.
	$basefile = basename ($file);

	#
	# If running under MSWindows...
	if ($^O =~ /win/i) {
		require Win32::Process;
		$cmd = $ENV{"COMSPEC"};
		$args = "$cmd /c \"cd $loadutilDir && $cmd /c "
			. basename($loadutil) . " -dv "  
			. " " . $basefile . "\"";
		my $process;
		Win32::Process::Create($process,
			$cmd,
			$args,
			0,
			DETACHED_PROCESS,
			'.') || die "$$: Unable to start batch application.";

		# Record PID of batch application in the database.
		&UpdatePIDBatchApplication(0, $current_poid);

		# Wait for the batch application to finish.
		$process->Wait(INFINITE);

		# Get the exit code and convert to a signed number.
		$process->GetExitCode($exitcode);
		my ($loadnotifystatus) = &convertUnsignedToSignedInt($exitcode);
	}

	#
	# Else if running under some other operating system like Unix...
	else {
		$loadnotifyCmd = basename($loadutil) . " -dv "
			  . " " . $basefile;
		my $loadnotifypid;
		if (!defined($loadnotifypid = fork())) {
			die "$$: Cannot start batch application: $!";
		} elsif ($loadnotifypid == 0) {
			$Command = "cd $loadutilDir; $loadnotifyCmd";
			exec($Command);
			die "$$: Cannot execute batch application: $!";
		} else {
			# Record PID of batch application in the database.
			&UpdatePIDBatchApplication($loadnotifypid, $current_poid);

			# Wait for the batch application to finish.
			waitpid($loadnotifypid,0);

			# Get the exit code and convert to a signed number.
			$exitcode = ($? >> $UNIX_SHIFT);
			my ($loadnotifystatus) = &convertUnsignedToSignedInt($exitcode);
		}
	}


	#
	# Log a debugging message in the handler log file.
	if ($DEBUG) {
		print LOG "$PID: The batch application returned $loadnotifystatus.\n";
	}
	#
	# Remove the lock file 
	#
	close(LOCK);
	unlink $lock_File;


	#
	# Move files based on the return status.
	#

	# Form full pathname of file to be moved.
	$procfile = $PROCESSING . "/" . $basefile;

	$localtime = localtime();
	if ($loadnotifystatus == $NO_ERROR) {
		if ($DEBUG) {
			print LOG "$PID: File ". basename ($procfile)." "
				. "processed successfully by the "
				. "batch application at $localtime.\n";
		}
		&callTheMoveToArchive($procfile);
		&HandlerDie($COMPLETED_NO_ERROR, $current_poid);
	}

	elsif ($loadnotifystatus == $FILE_CHECK_ERROR) {
		print LOG "$PID: File ". basename ($procfile)." was rejected "
			. "by the batch application at $localtime.\n";
		&callTheMoveToReject($procfile);
		&HandlerDie($REJECTED, $current_poid);
	}

	else {
		print LOG "$PID: Failed to start the batch application "
			. "at $localtime\n";
		print LOG "$PID: Unexpected loadnotify exit code: $loadnotifystatus.\n";
		&callTheMoveToReject($procfile);
		&HandlerDie($FAIL_TO_START_LOADNOTIFY, $current_poid);
	}

	#
	# Break the foreach loop
	last;
}

# Make sure a file was moved.
if ($moved_a_file != 1)
{
	&HandlerDie($FAIL_TO_MOVE_FILE, $current_poid);
}

#
# This point should not be reached...
clean_exit(0);


#
#------------------------------------------------------------------
# callTheMoveToProcessing - move the file from the staging directory to
# the processing directory.
#
# Parameter: the file name in the staging directory
#
# Returns: file not found or move failed = -1, any other failure = 0, success = 1
#
sub callTheMoveToProcessing {
	local($processingFile) = @_;
	if (! -e $processingFile) {
		print LOG "$PID: $processingFile does not exist.\n";
		return (-1);
	}
	if (! -d $PROCESSING) {
		print LOG "$PID: Processing directory $PROCESSING does "
			. "not exist.\n";
		return (0);
	}
	$ret = move "$processingFile", "$PROCESSING/$_";
	if ($ret != 1) {
		print LOG "$PID: Failed to move $processingFile to "
			. "$PROCESSING.\n";
		return (-1); # Could have been moved by another handler
			     # since these ops are non-atomic;
			     # this would not occur with other move subroutines
			     # since they have a known file in use.
	}
	if ($DEBUG) {
		print LOG "$PID: Moved $processingFile to $PROCESSING.\n";
	}
	return (1);
}


#
#------------------------------------------------------------------
# callTheMoveToArchive - move the file from the processing directory to
# the archive directory.
#
# Parameter: the file name in the processing directory
#
# Returns: failure = 0 and success = 1
#
sub callTheMoveToArchive {
	local($archiveFile) = @_;
	if (! -e $archiveFile) {
		print LOG "$PID: $archiveFile does not exist.\n";
		return (0);
	}
	if (! -d $ARCHIVE) {
		if (!createPath($ARCHIVE, 0, 0755)) {
			print LOG "$PID: Failed to create archive directory "
				. "$ARCHIVE: $!\n";
			return (0);
		}
	}
	$ret = move "$archiveFile", "$ARCHIVE/$_";
	if ($ret != 1){
		print LOG "$PID: Failed to move $archiveFile to $ARCHIVE.\n";
		return (0);
	}
	if ($DEBUG){
		print LOG "$PID: Moved $archiveFile to $ARCHIVE.\n";
	}
	return (1);
}


#
#------------------------------------------------------------------
# callTheMoveToReject - move the file from the processing directory to
# the reject directory.
#
# Parameter: the file name in the processing directory
#
# Returns: failure = 0 and success = 1
#
sub callTheMoveToReject {
	local($rejectFile) = @_;
	if (! -e $rejectFile) {
		print LOG "$PID: $rejectFile does not exist.\n";
		return (0);
	}
	if (! -d $REJECT) {
		if (!createPath($REJECT, 0, 0755)) {
			print LOG "$PID: Failed to create reject directory "
				. "$REJECT: $!\n";
			return (0);
		}
	}
	$ret = move "$rejectFile", "$REJECT/$_";
	if ($ret != 1) {
		print LOG "$PID: Failed to move $rejectFile to $REJECT.\n";
		return (0);
	}
	if ($DEBUG) {
		print LOG "$PID: Moved $rejectFile to $REJECT.\n";
	}
	return (1);
}

#
#------------------------------------------------------------------
# callTheMoveToStaging - move the file from the processing directory to
# the staging directory.
#
# Parameter: the file name in the processing directory
#
# Returns: failure = 0 and success = 1
#
sub callTheMoveToStaging {
	local($stagingFile) = @_;
	if (! -e $stagingFile) {
		print LOG "$PID: $stagingFile does not exist.\n";
		return (0);
	}
	if (! -d $STAGING) {
		print LOG "$PID: $STAGING does not exist.\n";
		return (0);
	}
	if (! -d $PROCESSING) {
		print LOG "$PID: $PROCESSING does not exist.\n";
		return (0);
	}
	if (!copy ($stagingFile, "$STAGING/$_")) {
		print LOG "$PID: Failed to copy $stagingFile to "
			. "the staging directory: $!\n";
		&HandlerDie($PILOT_ERROR, $current_poid);
	}
	if (!unlink($stagingFile, "$PROCESSING/$_")) {
		print LOG "$PID: Failed to unlink $stagingFile from "
			. "the processing directory: $!\n";
		&HandlerDie($PILOT_ERROR, $current_poid);
	}
	if ($DEBUG) {
		print LOG "$PID: Moved $stagingFile to $STAGING.\n";
	}
	return (1);
}

#
#
#------------------------------------------------------------------
# createPath - create the directory specified by the path arg, including
#	       all intermediate directories.
#
# Parameters:
#	$paths   -- either a path string or ref to list of paths
#	$verbose -- optional print "mkdir $path" for each directory created
#	$mode    -- optional permissions, defaults to 0777
#
# Returns: failure = 0 and success = 1
#
sub createPath {
	my($paths, $verbose, $mode) = @_;
	local($")="/";
	$mode = 0777 unless defined($mode);
	$paths = [$paths] unless ref $paths;
	my(@created,$path);
	foreach $path (@$paths) {
		next if -d $path;
		# Logic wants Unix paths, so go with the flow.
		$path = VMS::Filespec::unixify($path) if $Is_VMS;
		my $parent = File::Basename::dirname($path);
		push(@created, createPath($parent, $verbose, $mode))
			unless (-d $parent);
		print "mkdir $path\n" if $verbose;
		mkdir($path,$mode) || return 0;
		push(@created, $path);
	}
	@created;
}

#
#------------------------------------------------------------------
# HandlerDie - update the status object and exit.
#
sub HandlerDie() {
	$T_time = pcmif::pin_perl_time();
	local($status, $POID) = @_;

	# Create the flist to update the status to the passed arg.
	$f1 = << "END"
	0 PIN_FLD_POID				     POID [0] $POID
	0 PIN_FLD_END_T				   TSTAMP [0] ($T_time)
	0 PIN_FLD_STATUS			     ENUM [0] $status
END
;

	# Convert the flist string into the input flist
	$flistp = pcmif::pin_perl_str_to_flist($f1, $db_no, $ebufp);
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: Flist conversion failed:\n$f1\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		clean_exit(1);
	}

	# Call opcode to set the status.
	$out_flistp = pcmif::pcm_perl_op($pcm_ctxp,
			"PCM_OP_WRITE_FLDS", 0, $flistp, $ebufp);

	# If there is an error, log a message and terminate.
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: Failed to update handler object.\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		$out = pcmif::pin_perl_flist_to_str($out_flistp, $ebufp);
		pcmif::pin_flist_destroy($flistp);
		pcmif::pin_flist_destroy($out_flistp);
		clean_exit(1);
	}

	# These are the SampleHandler exit codes.
	if ($status == $COMPLETED_NO_ERROR) {
		$exitval = 0;
	}
	elsif ($status == $WITH_ERROR) {
		$exitval = 2;
	}
	elsif ($status == $REJECTED) {
		$exitval = 3;
	}
	elsif ($status == $PILOT_ERROR) {
		$exitval = 4;
	}
	elsif ($status == $NO_FILE_TYPE) {
		$exitval = 5;
	}
	elsif ($status == $FAIL_TO_MOVE_FILE) {
		$exitval = 6;
	}
	elsif ($status == $NO_LOADNOTIFY_EXEC) {
		$exitval = 7;
	}

	# Destroy the input and return flists.
	pcmif::pin_flist_destroy($flistp);
	pcmif::pin_flist_destroy($out_flistp);

	# Close the connection to the CM.
	pcmif::pcm_context_close($pcm_ctxp, 0, $ebufp);
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: Error while closing CM connection.\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		clean_exit($exitval);
	}

	# Terminate this handler application.
	if ($DEBUG) {
		print LOG "$PID: Handler completed operations, exiting...\n";
	}
	clean_exit($exitval);
}


#
#------------------------------------------------------------------
# UpdatePIDBatchApplication - store the batch application PID in the database.
#
sub UpdatePIDBatchApplication() {
	$T_time = pcmif::pin_perl_time();
	local($PID, $POID) = @_;

	# Create the flist to store the PID value.
	$f1 = << "END"
	0 PIN_FLD_POID				     POID [0] $POID
	0 PIN_FLD_BATCH_HANDLER_INFO		SUBSTRUCT [0]
	1   PIN_FLD_BATCH_APPLICATION_PID	      INT [0] $PID
END
;

	# Convert the flist string into the input flist.
	$flistp = pcmif::pin_perl_str_to_flist($f1, $db_no, $ebufp);
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: Flist conversion failed:\n$f1\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		clean_exit(1);
	}

	# Call opcode to set the PID.
	$out_flistp = pcmif::pcm_perl_op($pcm_ctxp,
			"PCM_OP_WRITE_FLDS", 0, $flistp, $ebufp);

	# If there is an error, log a message and terminate.
	if (pcmif::pcm_perl_is_err($ebufp)) {
		print LOG "$PID: PCM_OP_WRITE_FLDS failed.\n";
		pcmif::pcm_perl_print_ebuf($ebufp);
		$out = pcmif::pin_perl_flist_to_str($out_flistp, $ebufp);
		pcmif::pin_flist_destroy($flistp);
		pcmif::pin_flist_destroy($out_flistp);
		clean_exit(1);
	}

	# Destroy the input and return flists.
	pcmif::pin_flist_destroy($flistp);
	pcmif::pin_flist_destroy($out_flistp);

	return(1);
}

#
#------------------------------------------------------------------
# Usage: Print usage message and exit.
sub usage {
	print STDERR "Usage: $0 -p <hander_poid> { -d <dead_handler_poid> }\n";
	clean_exit(-1);
}

#
#------------------------------------------------------------------
# We don't want to leave any open files laying around,
# so close them here.
#
sub clean_exit {
        local($exitcode) = @_;
        close(LOG); # doesn't matter if it was opened or not.
        exit($exitcode);
}

#
#------------------------------------------------------------------
# Find the oldest file.
#
sub byage {
	$age{$b}<=>$age{$a}
}

#
#------------------------------------------------------------------
# Convert the unsigned int to signed value.
#
sub convertUnsignedToSignedInt {
	local($exitcode) = @_;

	if ($^O =~/win/i) {
		# Number of bits in NT other than the sign bit
		$valueBitLength = 31;
		# Decimal for binary 1 followed by 31 zeroes
		$decrementValue = 4294967296;
	}
	else {
		# Number of bits in Unix other than the sign bit
		$valueBitLength = 7;
		# Decimal for binary 1 followed by 7 zeroes
		$decrementValue = 256;
	}

	$lastBit = $exitcode >> $valueBitLength;
	if ($lastBit == 1) {
		$loadnotifystatus = ($exitcode - $decrementValue);
	}
	else {
		$loadnotifystatus = $exitcode;
	}
	return ($loadnotifystatus);
}

