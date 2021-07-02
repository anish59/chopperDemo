# chopper_demo

Application showcasing illustration for core concepts such as Chopper, bloc, flavor, mock
environment, dependency injection, pagination etc.

## Getting Started

### Chopper demo

<ins>commands</ins>
- for creating auto generated files </br>
=> **flutter packages pub run build_runner watch**
- note if while generating we get any issue we can try **Invalidate cache** and then run following
commands.</br>
 **flutter clean**</br>
 **flutter pub get**</br>
 **flutter packages pub run build_runner build --delete-conflicting-outputs**</br>
 then run that  **flutter packages pub run build_runner watch**
 
 - code snippet for generating builtValue model class:

```
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'dart:convert';

part '$package_name$.g.dart';


abstract class $CLASS_NAME$ implements Built<$CLASS_NAME$, $CLASS_NAME$Builder> {
  $CLASS_NAME$._();
  factory $CLASS_NAME$([void Function($CLASS_NAME$Builder) updates]) = _$$$CLASS_NAME$;
  static Serializer<$CLASS_NAME$> get serializer =>_$$$objectName$Serializer;
  
  String toJson() {
    return json.encode(Serializers().serializeWith($CLASS_NAME$.serializer, this));
  }

  static $CLASS_NAME$? fromJson(String jsonString) {
    return Serializers()
        .deserializeWith($CLASS_NAME$.serializer, jsonDecode(jsonString));
  }
}
//run below command for creating auto generate files
//flutter packages pub run build_runner watch 
```

----------------------------------------------------------------------------------------
**Flavor build generation commands**
- for creating flavor builds => **flutter build apk --flavor prod**
- for creating flavor builds with entry point configuration => **flutter build apk --flavor prod -t
 lib/main_prod.dart**
 note:
  1.  just keep string translatable false for production or lint disabling for translatable
  from gradle.
  2. todo : IOS flavor is remaining, as XCode is required for that.
 ------------------------------------------------------------------------------------------

Steps for creating built auto generated file: 
1. create [built_Model] file create BuiltModel class. (note: you can use blts custom made snippet)
2. add builtclass name under const parameter in serializer class and see if autogenerated
 serializer class have its setter implementation (eg: @SerializersFor(const [BuiltPost,BuiltJob]))
 
 -------------------------------------------------------------------------------------------
 
 ### FlutterBloc Demo
 
 - Note if you don't want to rebuild widget on state change , its okay we don't have to make a
  state or event for it we can handle simply on the particular action. But there might be something
  which can prevent re-building the widget look for it in the documentation or somewhere.
   
 -------------------------------------------------------------------------------------------
 
  ### Dependency injection
  
  - Used get_it library for this. 
  - look for injection container.
  -------------------------------------------------------------------------------------------
 
 ### Pagination
 - follow reference https://bloclibrary.dev/#/flutterinfinitelisttutorial
 - for a pagination list create a separate stateful widget and maintain its bloc, event and state
   as given in above reference, as we need to get the bloc object in the init state of list widget
   to maintain state properly for this.
 - keep pagination something like 15 or 20 which is more than screen height.
  -------------------------------------------------------------------------------------------

#### Todo:
1. flavour implementation is not complete as I am unable to get flavor in code. (I guess as I
 have not implemented for IOS, it so) so implement it afterwards.
2. mock failure response is remaining to parse.
