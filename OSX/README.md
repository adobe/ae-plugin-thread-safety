Our tool for detecting symbols on OSX is a simple bash wrapper over a call to nm. Run this over a compiled binary to find potentially unsafe symbols:
	./check_symbols_for_thread_safety.sh path/to/your/binary
This will run nm on your binary and look for any static or global state in your project. Symbols will be of the form:
	[address] [symbol type] [symbol name]
for more information on symbol types, see https://linux.die.net/man/1/nm .

