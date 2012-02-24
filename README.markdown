Orange!
=======

Orange is a data binding language you can use in your iOS projects--you can replace your controller code with it. It's also good for writing layout code.

The basic construct in Orange is a __bind statement__. It looks like this:

    object.keypath <= expression

This means "when the result of expression changes, assign it to the location at `object.keypath`.

You can put bind statements inside a __scope__. This allows you to bind multiple key paths of a single object:

    object.long.key.path {
        .bottom <= 10.0;
        .top <= 0.0;
    }

You can nest scopes:

    view { .backgroundColor { .red <= 0.5; .green <= 0.2; .blue < 1.0 } }

Note that the bind statements inside a scope don't need to specify the target object--it is specified by the key path in the parent scope. 
At the top level of your script the parent scope is the object the script is attached to. 
The keyword `self` represents "the object to script is attached to".

Normally bindings are always ‘live’. Changes in the expression are applied at the destination keypath immediately. 
You can specify a __trigger__ as a scope and this causes your bindings to run only at certain times. 
For example, you can use the trigger `"layout"` to run your bindings during `-layoutSubviews`:

    <layout> {
        .subviews {
	    .left <= 10.0;
	    .right <= 100.0;
        }
    }

Compile your scripts like this:

    [ OrangeScript scriptWithContext:myObject format:@".height <= 20" ] ;

You can refer to object instances in Orange script by passing them as additional arguments to the compiler:

    [ OrangeScript scriptWithContext:myObject format:@".title <= %@.title", titleContainer ] ;

This works like printf... Use the `%@` specifier.

Expressions
-----------

Expressions are written in prefix notation.

__Examples__:

addition

	+ 5 10

subtraction (take 5 from 10)

	- 10 5

ternary (if/then/else) operator:

	#
	# if a.hidden then result is 0
	# otherwise result is a.width
	#

	? a.hidden 0 a.width

you can also optionally group subexpressions using parentheses:

	#
	# add 15 to (10 - 7)
	#

	+ ( - 10 7 ) 15
