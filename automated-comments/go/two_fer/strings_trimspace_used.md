Don't worry about cleaning up input in exercises on exercism. The platform does not require that.

Even if this were a real application all the functions within your applications should not clean up
input data. If you have potentially bad data coming from a source you should clean it up in the code reading
from that source. Then you can consider the data clean within the rest of your code.