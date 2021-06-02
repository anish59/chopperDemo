# chopper_demo

A new Flutter application.

## Getting Started

### Important commands

- for creating auto generated files => **flutter packages pub run build_runner watch**

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

#### Todo:
1. flavour implementation is not complete as I am unable to get flavor in code. (I guess as I
 have not implemented for IOS, it so) so implement it afterwards.
2. mock failure response is remaining to parse.