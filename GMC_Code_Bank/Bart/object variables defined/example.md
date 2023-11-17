The following is a very simple way to figure out, through code, which [object variables](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObject_Properties%2FObject_Variables.htm) are defined for an instance.
The trick is to get the list of object variable names as the very first thing in the Create event, before any other variables are defined:

```gml
/// The Create event
// There should be nothing here!
names = variable_instance_get_names(id);
// names now contains the names of all object variables

event_inherited(); // Define this here, AFTER looking up the list of names
```

The above also works for object variables that are inherited from a parent object.