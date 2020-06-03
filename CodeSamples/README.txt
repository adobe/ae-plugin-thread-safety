These source files contain examples of issues you may run into while reviewing your plugins for thread safety issues.

Has_Issues.cpp contains some examples of global state you might run into, while Issues_Fixed.cpp contains our recommended way of fixing them.

For more information, see the Thread Safety portion of After Effects' SDK docs at http://ae-plugin-sdk.aenhancers.com/effect-details/multi-frame-rendering-in-ae.html

Note: These two sample files contain just a few modifications on top of the SDK skeleton sample. If you're interested in seeing what symbols are identified by the ae-plugin-thread-safe tools in this repo, you can replace Skeleton.cpp with either of these files and build.
