#Adding a sorting algorithm

Create a new class and make it a subclass of `SortingAlgorithm`. Then implement the `+ (NSArray *)sort:(NSArray *)persons;` method.

The programm will automatically run and measure the performance for all of your sort algorithms. When they are completed it will print the results to the console. It will also check your sort results against reference results, if your algorithm sorts differently it will throw an exception.

#Sorting criteria
You need to sort by age then by last name and then by first name. This here is the reference implementation:

     NSArray *referenceSortResult = [[persons copy] 		sortedArrayUsingComparator:^NSComparisonResult(Person *person1, Person *person2) {
            if (person1.age < person2.age) {
                return NSOrderedAscending;
            } else if (person1.age > person2.age) {
                return NSOrderedDescending;
            } else {
                NSComparisonResult lastNameCompare = [person1.lastName compare:person2.lastName];
                if (lastNameCompare != NSOrderedSame) {
                    return lastNameCompare;
                } else {
                    return [person1.firstName compare:person2.firstName];
                }
            }
        }]; 
        
#Amount of elements to sort

In `main.m` you'll find a constant called `kPersonCount`. That constant determines the amount of persons created.