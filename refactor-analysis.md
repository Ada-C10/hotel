#How easy is it to follow your own instructions?
They make sense because I wrote them, but they could be more explicit for other to understand
5 bullet point, it's not clear where it appears. It should have something like "when you create a date range, if you don't want to include the last item in this case date, use 3 dots"
#Do these refactors improve the clarity of your code?
Mostly, some of them are not accurate like 4.2, the add_range does not add a block, it makes a reservation so it should be called create_reservation
#Do you still agree with your previous assesment, or could your refactor be further improved?
It could try to make sure that method from one class do not read or modifies instance variables loose coupled.
