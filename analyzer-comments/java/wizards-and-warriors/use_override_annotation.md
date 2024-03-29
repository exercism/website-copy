# use override annotation

Although not strictly necessary, it is a good practice to use the `@Override` annotation when overriding methods from a superclass.

Doing so may help prevent errors; if a method marked with `@Override` fails to correctly override a method in one of its superclasses, the compiler will generate an error.
