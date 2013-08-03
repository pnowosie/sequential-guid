sequencial-guid
===============

Node package for generating sequencial unique identifiers based on node-uuid.

How-to
======

Start with install a package 
> npm install sequencial-guid

In your code require library code and create object

var Uid = require('sequencial-guid')
var uid = new Uid

Creating new instance of guid class cause generation of the seed 
console.log( uid.seed )   // output unique identifier like this: 6e44dc51-804d-47ab-a933-f94641cf86cf

If you want to deffer generating seed with unique value or provided your own, before object instantiation do
Uid.prototype.deferInit = true

and now new object has undefined seed until you call next, we can specify value for seed
var iid = new Uid

iid.seed = '00000000-0000-4000-a000-000000000000'

and generate unique identifiers

console.log( uid.next() )	// '00000000-0000-4000-a000-000000000001'
console.log( uid.next() )	// '00000000-0000-4000-a000-000000000002'
console.log( uid.next() )	// '00000000-0000-4000-a000-000000000003'
console.log( uid.next() )	// '00000000-0000-4000-a000-000000000004'
console.log( uid.next() )	// '00000000-0000-4000-a000-000000000005'

That's all, thanks for reading :)