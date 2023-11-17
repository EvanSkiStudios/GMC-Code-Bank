All methods are O(1) time complexity, O(1) space complexity.

```new LinkedList()```  
Creates a new linked list.

```LinkedList#size```  
The size (number of elements) of the linked list.

```LinkedList#insertFirst(value)```  
Inserts an element into the start of the list.

```LinkedList#insertLast(value)```  
Inserts an element into the end of the list.

```LinkedList#deleteFirst()```  
Deletes the first element in the list; returns the value of that element.

```LinkedList#deleteLast()```  
Deletes the last element in the list; returns the value of that element.

```LinkedList#clear()```  
Clears the list; returns the number of elements destroyed.

```LinkedList#empty()```  
Returns true if the list is empty, and false otherwise.

```LinkedList#getViewFirst()```  
Returns a view (type LLView) of the first element. This allows looping through the list.

```LinkedList#getViewLast()```  
Returns a view (type LLView) of the last element. This allows looping through the list.

```LLView#current```  
Returns the value of the viewed element. Setting does not affect the linked list.

```LLView#previous()```  
Moves the view to the previous element. Returns true if said element exists, and false otherwise.

```LLView#insertBefore(value)```  
Inserts an element before the current (viewed) element.

```LLView#insertAfter(value)```  
Inserts an element after the current (viewed) element.

```LLView#destroyBefore()```  
Destroys the element before the current (viewed) element; returns the value of the destroyed element.

```LLView#destroyAfter()```  
Destroys the element after the current (viewed) element; returns the value of the destroyed element.

```LLView#set(value)```  
Sets the value of the current (viewed) element.