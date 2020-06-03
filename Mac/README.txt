This is After Effects' internal tool for finding possible thread safety issues in object files on macOS. It filters the output of the nm command line tool to show global and static variables. The input is an object file or linked binary.

Syntax:
	check_symbols_for_thread_safety.sh [file]

This will run nm on your binary and look for any static or global state in your project. See the the section on plug-in thread safety at http://ae-plugin-sdk.aenhancers.com/ for more detail on how to interpret output and fix issues.
