//Strings
String str = 'Hello, Salesforce!';
// Length of the string
Integer length = str.length();
System.debug('Length: ' + length); // Output: 18
// Convert to uppercase
String upper = str.toUpperCase();
System.debug('Uppercase: ' + upper); // Output: HELLO, SALESFORCE!
// Convert to lowercase
String lower = str.toLowerCase();
System.debug('Lowercase: ' + lower); // Output: hello, salesforce!
// Substring from index 7 to end
String substring1 = str.substring(7);
System.debug('Substring (7 to end): ' + substring1); // Output: Salesforce!
// Substring from index 0 to 4
String substring2 = str.substring(0, 5);
System.debug('Substring (0 to 5): ' + substring2); // Output: Hello
// Conditional Statements
System.debug('--- Conditional Statements ---');
// if statement
Integer x = 10;
if (x > 5){
    System.debug('x is greater than 5');
}
// if-else statement
if (x < 5){
    System.debug('x is less than 5');
} else{
    System.debug('x is greater than or equal to 5');
}
// if-else if-else statement
if (x < 5){
    System.debug('x is less than 5');
} else if (x == 10){
    System.debug('x is equal to 10');
} else{
    System.debug('x is greater than 5 but not 10');
}
// ternary operator
String result = (x > 5) ? 'x is greater than 5' : 'x is not greater than 5';
System.debug(result);
// switch statement
Integer day = 3;
switch  on day{
    when 1{
        System.debug('Monday');
    }
    when 2{
        System.debug('Tuesday');
    }
    when 3{
        System.debug('Wednesday');
    }
    when 4{
        System.debug('Thursday');
    }
    when 5{
        System.debug('Friday');
    }
    when 6{
        System.debug('Saturday');
    }
    when 7{
        System.debug('Sunday');
    }
    when else{
        System.debug('Invalid day');
    }
}
// Loops
System.debug('--- Loops ---');
// for loop
for (Integer i = 0; i < 5; i++){
    System.debug('for loop iteration: ' + i);
}
// for-each loop
List<String> names = new List<String>{
    'Alice', 'Bob', 'Charlie'
}
;
for (String name : names){
    System.debug('for-each loop: ' + name);
}
// while loop
Integer count = 0;
while (count < 3){
    System.debug('while loop count: ' + count);
    count++;
}
// do-while loop
count = 0;
do{
    System.debug('do-while loop count: ' + count);
    count++;
}
while (count < 3);
// Lists
System.debug('--- Lists ---');
List<Integer> numbers = new List<Integer>{
    1, 2, 3, 4, 5
}
;
numbers.add(6);
numbers.addAll(new List<Integer>{
    7, 8, 9
}
);
System.debug('List after adding elements: ' + numbers);
numbers.remove(0); // Remove by index
System.debug('List after removing first element: ' + numbers);
numbers.remove(5); // Remove by value
System.debug('List after removing element with value 5: ' + numbers);
Integer firstElement = numbers.get(0);
System.debug('First element of the list: ' + firstElement);
Boolean containsValue = numbers.contains(3);
System.debug('List contains 3: ' + containsValue);
// Sets
System.debug('--- Sets ---');
Set<String> fruits = new Set<String>{
    'Apple', 'Banana', 'Cherry'
}
;
fruits.add('Date');
fruits.addAll(new List<String>{
    'Elderberry', 'Fig', 'Grape'
}
);
System.debug('Set after adding elements: ' + fruits);
fruits.remove('Apple');
System.debug('Set after removing Apple: ' + fruits);
Boolean containsFruit = fruits.contains('Banana');
System.debug('Set contains Banana: ' + containsFruit);
Set<String> anotherSet = new Set<String>{
    'Fig', 'Grape', 'Honeydew'
}
;
Set<String> intersection = fruits.clone();
intersection.retainAll(anotherSet);
System.debug('Intersection of two sets: ' + intersection);
// Maps
System.debug('--- Maps ---');
Map<String, Integer> nameToAge = new Map<String, Integer>{
    'Alice' => 30, 'Bob' => 25
}
;
nameToAge.put('Charlie', 35);
nameToAge.putAll(new Map<String, Integer>{
    'David' => 40, 'Eve' => 28
}
);
System.debug('Map after adding elements: ' + nameToAge);
Integer ageOfAlice = nameToAge.get('Alice');
System.debug('Age of Alice: ' + ageOfAlice);
nameToAge.remove('Bob');
System.debug('Map after removing Bob: ' + nameToAge);
Boolean containsKey = nameToAge.containsKey('Charlie');
System.debug('Map contains key Charlie: ' + containsKey);
List<Integer> values = nameToAge.values();
Boolean containsValueInMap = values.contains(28);
System.debug('Map contains value 28: ' + containsValueInMap);
Set<String> mapKeys = nameToAge.keySet();
System.debug('Keys of the map: ' + mapKeys);
List<Integer> mapValues = nameToAge.values();
System.debug('Values of the map: ' + mapValues);
// JSON serialization and deserialization for collections
System.debug('--- JSON ---');
String jsonList = JSON.serialize(numbers);
System.debug('Serialized list to JSON: ' + jsonList);
String jsonSet = JSON.serialize(fruits);
System.debug('Serialized set to JSON: ' + jsonSet);
String jsonMap = JSON.serialize(nameToAge);
System.debug('Serialized map to JSON: ' + jsonMap);
List<Integer> deserializedList = (List<Integer>)JSON.deserialize(jsonList, List<Integer>.class);
System.debug('Deserialized JSON to list: ' + deserializedList);
Set<String> deserializedSet = (Set<String>)JSON.deserialize(jsonSet, Set<String>.class);
System.debug('Deserialized JSON to set: ' + deserializedSet);
Map<String, Integer> deserializedMap = (Map<String, Integer>)JSON.deserialize(jsonMap, Map<String, Integer>.class);
System.debug('Deserialized JSON to map: ' + deserializedMap);